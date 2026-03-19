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

    // MARK: - Mock Data

    private let mockLoadedKey = "lalaretro_mock_loaded"

    func loadMockDataIfNeeded() {
        guard !defaults.bool(forKey: mockLoadedKey) else { return }

        let mockProducts: [Product] = [
            Product(id: UUID().uuidString, name: "Moisturizing Cream", brand: "CeraVe",
                    barcode: "3337875597395",
                    ingredients: ["Aqua", "Glycerin", "Cetearyl Alcohol", "Caprylic/Capric Triglyceride", "Cetyl Alcohol", "Ceramide NP", "Ceramide AP", "Ceramide EOP", "Dimethicone", "Phenoxyethanol", "Sodium Hyaluronate", "Cholesterol", "Tocopherol", "Xanthan Gum"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Niacinamide 10% + Zinc 1%", brand: "The Ordinary",
                    barcode: "769915190585",
                    ingredients: ["Aqua", "Niacinamide", "Pentylene Glycol", "Zinc PCA", "Dimethyl Isosorbide", "Tamarindus Indica Seed Gum", "Xanthan Gum", "Isoceteth-20", "Ethoxydiglycol", "Phenoxyethanol", "Chlorphenesin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Toleriane Sensitive Cream", brand: "La Roche-Posay",
                    barcode: "3337875588676",
                    ingredients: ["Aqua", "Glycerin", "Butyrospermum Parkii Butter", "Cetearyl Alcohol", "Niacinamide", "Dimethicone", "Propanediol", "Ceramide NP", "Tocopherol", "Sodium Hydroxide", "Capryloyl Glycine"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Ultra Facial Cream", brand: "Kiehl's",
                    barcode: "3605970024185",
                    ingredients: ["Aqua", "Glycerin", "Cyclohexasiloxane", "Squalane", "Bis-PEG-18 Methyl Ether Dimethyl Silane", "Sucrose Stearate", "Stearyl Alcohol", "PEG-8 Stearate", "Phenoxyethanol", "Prunus Armeniaca Kernel Oil", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Hydro Boost Water Gel", brand: "Neutrogena",
                    barcode: "3574661391786",
                    ingredients: ["Aqua", "Dimethicone", "Glycerin", "Dimethicone/Vinyl Dimethicone Crosspolymer", "Phenoxyethanol", "Sodium Hyaluronate", "Cetearyl Olivate", "Polyacrylamide", "Ethylhexylglycerin", "Chlorphenesin", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Cicaplast Baume B5+", brand: "La Roche-Posay",
                    barcode: "3337875586269",
                    ingredients: ["Aqua", "Hydrogenated Polyisobutene", "Dimethicone", "Glycerin", "Butyrospermum Parkii Butter", "Panthenol", "Aluminum Starch Octenylsuccinate", "Propanediol", "Cetyl PEG/PPG-10/1 Dimethicone", "Zinc Gluconate", "Madecassoside", "Manganese Gluconate", "Copper Gluconate"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),
        ]

        for product in mockProducts {
            _ = saveProduct(product)
        }

        defaults.set(true, forKey: mockLoadedKey)
    }
}
