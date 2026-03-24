import SwiftUI

@main
struct LalaRetroApp: App {
    init() {
        // Start iCloud sync before loading data
        CloudSyncService.shared.startSync()
        LocalStorageService.shared.loadMockDataIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
