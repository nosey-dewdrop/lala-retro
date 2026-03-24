import Foundation
import Combine

/// Handles iCloud key-value store synchronization.
/// Uses NSUbiquitousKeyValueStore for transparent cloud sync with offline-first behavior.
/// Data is always written to both UserDefaults (local cache) and iCloud KVS (cloud sync).
/// When iCloud is unavailable, UserDefaults serves as the source of truth.
/// When iCloud syncs, remote changes are merged into local storage.
final class CloudSyncService {
    static let shared = CloudSyncService()

    private let cloudStore = NSUbiquitousKeyValueStore.default
    private let localDefaults = UserDefaults.standard

    // Keys must match LocalStorageService keys
    private let productsKey = "lalaretro_products"
    private let reactionsKey = "lalaretro_reactions"
    private let suspectsKey = "lalaretro_suspects"
    private let migrationKey = "lalaretro_cloud_migration_done"
    private let lastSyncKey = "lalaretro_last_sync_timestamp"

    // Notification for when remote data changes
    static let didReceiveRemoteChanges = Notification.Name("CloudSyncDidReceiveRemoteChanges")

    private init() {}

    // MARK: - Setup

    /// Call once at app launch to start listening for iCloud changes
    func startSync() {
        // Listen for iCloud key-value store changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cloudStoreDidChange(_:)),
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: cloudStore
        )

        // Trigger initial sync
        cloudStore.synchronize()

        // Migrate existing UserDefaults data to iCloud if not done yet
        migrateIfNeeded()
    }

    // MARK: - Migration

    /// Migrates existing UserDefaults data to iCloud key-value store (one-time)
    private func migrateIfNeeded() {
        guard !localDefaults.bool(forKey: migrationKey) else { return }

        // Push existing local data to iCloud
        if let productsData = localDefaults.data(forKey: productsKey) {
            cloudStore.set(productsData, forKey: productsKey)
        }

        if let reactionsData = localDefaults.data(forKey: reactionsKey) {
            cloudStore.set(reactionsData, forKey: reactionsKey)
        }

        if let suspects = localDefaults.stringArray(forKey: suspectsKey) {
            cloudStore.set(suspects, forKey: suspectsKey)
        }

        cloudStore.synchronize()
        localDefaults.set(true, forKey: migrationKey)
    }

    // MARK: - Write (dual-write to local + cloud)

    func saveProducts(_ data: Data) {
        localDefaults.set(data, forKey: productsKey)
        cloudStore.set(data, forKey: productsKey)
        updateSyncTimestamp()
        cloudStore.synchronize()
    }

    func saveReactions(_ data: Data) {
        localDefaults.set(data, forKey: reactionsKey)
        cloudStore.set(data, forKey: reactionsKey)
        updateSyncTimestamp()
        cloudStore.synchronize()
    }

    func saveSuspects(_ suspects: [String]) {
        localDefaults.set(suspects, forKey: suspectsKey)
        cloudStore.set(suspects, forKey: suspectsKey)
        updateSyncTimestamp()
        cloudStore.synchronize()
    }

    // MARK: - Read (prefer local cache, cloud is backup)

    func getProductsData() -> Data? {
        localDefaults.data(forKey: productsKey)
    }

    func getReactionsData() -> Data? {
        localDefaults.data(forKey: reactionsKey)
    }

    func getSuspects() -> [String]? {
        localDefaults.stringArray(forKey: suspectsKey)
    }

    // MARK: - Remote Change Handling

    @objc private func cloudStoreDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonRaw = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? Int else {
            return
        }

        let reason = reasonRaw

        switch reason {
        case NSUbiquitousKeyValueStoreServerChange,
             NSUbiquitousKeyValueStoreInitialSyncChange:
            // Remote data changed — merge into local
            mergeRemoteChanges(userInfo: userInfo)

        case NSUbiquitousKeyValueStoreQuotaViolationChange:
            // Over 1MB limit — log but don't crash
            print("[CloudSync] iCloud KVS quota exceeded. Consider reducing stored data.")

        case NSUbiquitousKeyValueStoreAccountChange:
            // iCloud account changed — re-sync everything
            localDefaults.set(false, forKey: migrationKey)
            migrateIfNeeded()

        default:
            break
        }
    }

    private func mergeRemoteChanges(userInfo: [AnyHashable: Any]) {
        guard let changedKeys = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey] as? [String] else {
            return
        }

        for key in changedKeys {
            switch key {
            case productsKey:
                mergeProducts()
            case reactionsKey:
                mergeReactions()
            case suspectsKey:
                mergeSuspects()
            default:
                break
            }
        }

        // Notify the app that data changed so ViewModels can refresh
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: CloudSyncService.didReceiveRemoteChanges, object: nil)
        }
    }

    // MARK: - Merge Strategies

    /// Merge products: union by ID, prefer newer createdAt for conflicts
    private func mergeProducts() {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        let localProducts: [Product] = {
            guard let data = localDefaults.data(forKey: productsKey),
                  let products = try? decoder.decode([Product].self, from: data) else { return [] }
            return products
        }()

        let remoteProducts: [Product] = {
            guard let data = cloudStore.data(forKey: productsKey),
                  let products = try? decoder.decode([Product].self, from: data) else { return [] }
            return products
        }()

        // Build map: id -> product, prefer the one with later createdAt
        var merged: [String: Product] = [:]

        for product in localProducts {
            if let id = product.id {
                merged[id] = product
            }
        }

        for product in remoteProducts {
            if let id = product.id {
                if let existing = merged[id] {
                    // Keep the newer one
                    if product.createdAt > existing.createdAt {
                        merged[id] = product
                    }
                } else {
                    merged[id] = product
                }
            }
        }

        let result = Array(merged.values).sorted { $0.createdAt < $1.createdAt }

        if let data = try? encoder.encode(result) {
            localDefaults.set(data, forKey: productsKey)
            // Don't write back to cloud during merge to avoid loops
        }
    }

    /// Merge reactions: union by ID, prefer newer date for conflicts
    private func mergeReactions() {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        let localReactions: [UserReaction] = {
            guard let data = localDefaults.data(forKey: reactionsKey),
                  let reactions = try? decoder.decode([UserReaction].self, from: data) else { return [] }
            return reactions
        }()

        let remoteReactions: [UserReaction] = {
            guard let data = cloudStore.data(forKey: reactionsKey),
                  let reactions = try? decoder.decode([UserReaction].self, from: data) else { return [] }
            return reactions
        }()

        var merged: [String: UserReaction] = [:]

        for reaction in localReactions {
            if let id = reaction.id {
                merged[id] = reaction
            }
        }

        for reaction in remoteReactions {
            if let id = reaction.id {
                if let existing = merged[id] {
                    if reaction.date > existing.date {
                        merged[id] = reaction
                    }
                } else {
                    merged[id] = reaction
                }
            }
        }

        let result = Array(merged.values).sorted { $0.date < $1.date }

        if let data = try? encoder.encode(result) {
            localDefaults.set(data, forKey: reactionsKey)
        }
    }

    /// Merge suspects: simple union of both sets
    private func mergeSuspects() {
        let localSuspects = Set(localDefaults.stringArray(forKey: suspectsKey) ?? [])
        let remoteSuspects = Set(cloudStore.object(forKey: suspectsKey) as? [String] ?? [])
        let merged = Array(localSuspects.union(remoteSuspects)).sorted()

        localDefaults.set(merged, forKey: suspectsKey)
    }

    // MARK: - Helpers

    private func updateSyncTimestamp() {
        let timestamp = Date().timeIntervalSince1970
        localDefaults.set(timestamp, forKey: lastSyncKey)
        cloudStore.set(timestamp, forKey: lastSyncKey)
    }
}
