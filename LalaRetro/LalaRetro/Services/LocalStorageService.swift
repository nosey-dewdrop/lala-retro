import Foundation

class LocalStorageService {
    static let shared = LocalStorageService()
    private let defaults = UserDefaults.standard

    private let productsKey = "lalaretro_products"
    private let reactionsKey = "lalaretro_reactions"
    private let suspectsKey = "lalaretro_suspects"

    private init() {}

    // MARK: - Products

    func getAllProducts() -> [Product] {
        guard let data = defaults.data(forKey: productsKey) else { return [] }
        return (try? JSONDecoder().decode([Product].self, from: data)) ?? []
    }

    func searchProducts(query: String) -> [Product] {
        let q = query.lowercased()
        return getAllProducts().filter {
            $0.name.lowercased().contains(q) || $0.brand.lowercased().contains(q)
        }
    }

    func getProduct(id: String) -> Product? {
        getAllProducts().first { $0.id == id }
    }

    func getProductByBarcode(_ barcode: String) -> Product? {
        getAllProducts().first { $0.barcode == barcode }
    }

    func saveProduct(_ product: Product) -> Product {
        var products = getAllProducts()
        var saved = product
        if saved.id == nil {
            saved.id = UUID().uuidString
        }
        products.append(saved)
        if let data = try? JSONEncoder().encode(products) {
            defaults.set(data, forKey: productsKey)
        }
        return saved
    }

    // MARK: - Reactions

    func getReactions() -> [UserReaction] {
        guard let data = defaults.data(forKey: reactionsKey) else { return [] }
        return (try? JSONDecoder().decode([UserReaction].self, from: data)) ?? []
    }

    func saveReaction(_ reaction: UserReaction) {
        var reactions = getReactions()
        var saved = reaction
        if saved.id == nil {
            saved.id = UUID().uuidString
        }
        reactions.append(saved)
        if let data = try? JSONEncoder().encode(reactions) {
            defaults.set(data, forKey: reactionsKey)
        }
    }

    func deleteReaction(id: String) {
        var reactions = getReactions()
        reactions.removeAll { $0.id == id }
        if let data = try? JSONEncoder().encode(reactions) {
            defaults.set(data, forKey: reactionsKey)
        }
    }

    // MARK: - Suspects (Watchlist)

    func getSuspects() -> [String] {
        defaults.stringArray(forKey: suspectsKey) ?? []
    }

    func addSuspect(_ ingredient: String) {
        var suspects = getSuspects()
        let normalized = ingredient.lowercased().trimmingCharacters(in: .whitespaces)
        if !suspects.contains(normalized) {
            suspects.append(normalized)
            defaults.set(suspects, forKey: suspectsKey)
        }
    }

    func removeSuspect(_ ingredient: String) {
        var suspects = getSuspects()
        suspects.removeAll { $0 == ingredient.lowercased().trimmingCharacters(in: .whitespaces) }
        defaults.set(suspects, forKey: suspectsKey)
    }
}
