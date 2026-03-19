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

            Product(id: UUID().uuidString, name: "Peptide Glazing Fluid", brand: "Rhode",
                    barcode: "860005838011",
                    ingredients: ["Aqua", "Glycerin", "Niacinamide", "Pentylene Glycol", "Acetyl Hexapeptide-8", "Sodium Hyaluronate", "Panthenol", "Allantoin", "Betaine", "Hydroxyethyl Urea", "Phenoxyethanol", "Ethylhexylglycerin", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Peptide Water Cream", brand: "Rhode",
                    barcode: "860005838028",
                    ingredients: ["Aqua", "Glycerin", "Squalane", "Caprylic/Capric Triglyceride", "Cetearyl Alcohol", "Niacinamide", "Shea Butter", "Peptide Complex", "Sodium Hyaluronate", "Ceramide NP", "Tocopherol", "Phenoxyethanol", "Dimethicone"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Atobarrier 365 Cream", brand: "Aestura",
                    barcode: "8809517940012",
                    ingredients: ["Aqua", "Glycerin", "Cetyl Ethylhexanoate", "Hydrogenated Poly(C6-14 Olefin)", "1,2-Hexanediol", "Ceramide NP", "Cholesterol", "Phytosphingosine", "Dimethicone", "Cetearyl Alcohol", "Allantoin", "Panthenol", "Madecassoside", "Butyrospermum Parkii Butter", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Cica Balm", brand: "Aestura",
                    barcode: "8809517940029",
                    ingredients: ["Aqua", "Glycerin", "Cetearyl Alcohol", "Madecassoside", "Centella Asiatica Extract", "Panthenol", "Allantoin", "Betaine", "Ceramide NP", "Squalane", "Dimethicone", "Tocopherol", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Green Tea Hyaluronic Acid Cream", brand: "Yepoda",
                    barcode: "4260666130019",
                    ingredients: ["Aqua", "Glycerin", "Camellia Sinensis Leaf Extract", "Sodium Hyaluronate", "Niacinamide", "Butylene Glycol", "Cetearyl Alcohol", "Squalane", "Dimethicone", "Panthenol", "Allantoin", "Tocopherol", "Phenoxyethanol", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Relief Sun Rice + Probiotics SPF50+", brand: "Beauty of Joseon",
                    barcode: "8809738310243",
                    ingredients: ["Aqua", "Oryza Sativa Bran Extract", "Dibutyl Adipate", "Glycerin", "Diethylamino Hydroxybenzoyl Hexyl Benzoate", "Polymethylsilsesquioxane", "Niacinamide", "Cetyl Ethylhexanoate", "Lactobacillus Ferment", "Sodium Hyaluronate", "Tocopherol", "Dimethicone", "Phenoxyethanol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Glow Deep Serum Rice + Alpha-Arbutin", brand: "Beauty of Joseon",
                    barcode: "8809738310250",
                    ingredients: ["Aqua", "Oryza Sativa Bran Extract", "Glycerin", "Alpha-Arbutin", "Niacinamide", "Sodium Hyaluronate", "Butylene Glycol", "Panthenol", "Allantoin", "Adenosine", "Phenoxyethanol", "Ethylhexylglycerin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Hyaluronic Acid 2% + B5", brand: "The Ordinary",
                    barcode: "769915190011",
                    ingredients: ["Aqua", "Sodium Hyaluronate", "Pentylene Glycol", "Sodium Hyaluronate Crosspolymer", "Panthenol", "Ahnfeltia Concinna Extract", "Glycerin", "Phenoxyethanol", "Chlorphenesin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Protini Polypeptide Cream", brand: "Drunk Elephant",
                    barcode: "812343030015",
                    ingredients: ["Aqua", "Dicaprylyl Carbonate", "Glycerin", "Cetearyl Alcohol", "Cetearyl Olivate", "Sorbitan Olivate", "Acetyl Hexapeptide-8", "Copper Tripeptide-1", "Palmitoyl Tetrapeptide-7", "Sodium Hyaluronate", "Pygmy Waterlily Stem Cell Extract", "Squalane", "Ceramide NP", "Phenoxyethanol", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Lala Retro Whipped Cream", brand: "Drunk Elephant",
                    barcode: "812343030022",
                    ingredients: ["Aqua", "Glycerin", "Cetearyl Alcohol", "Isopropyl Palmitate", "Adansonia Digitata Seed Oil", "Passiflora Edulis Seed Oil", "Daucus Carota Sativa Seed Oil", "Ceramide AP", "Ceramide EOP", "Ceramide NP", "Phytosphingosine", "Cholesterol", "Sodium Hyaluronate", "Plantago Lanceolata Leaf Extract", "Phenoxyethanol", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Tatcha
            Product(id: UUID().uuidString, name: "The Dewy Skin Cream", brand: "Tatcha",
                    barcode: "0752830528100",
                    ingredients: ["Aqua", "Glycerin", "Squalane", "Dimethicone", "Propanediol", "Oryza Sativa Bran Extract", "Camellia Sinensis Leaf Extract", "Algae Extract", "Usnea Barbata Extract", "Hyaluronic Acid", "Ceramide AP", "Ceramide NP", "Cetearyl Alcohol", "Phenoxyethanol", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "The Water Cream", brand: "Tatcha",
                    barcode: "0752830528117",
                    ingredients: ["Aqua", "Glycerin", "Dimethicone", "Oryza Sativa Bran Extract", "Camellia Sinensis Leaf Extract", "Algae Extract", "Sophora Angustifolia Root Extract", "Wild Rose Extract", "Leopard Lily Extract", "Sodium Hyaluronate", "Dipotassium Glycyrrhizate", "Phenoxyethanol", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Glow Recipe
            Product(id: UUID().uuidString, name: "Watermelon Glow Niacinamide Dew Drops", brand: "Glow Recipe",
                    barcode: "0810007080017",
                    ingredients: ["Aqua", "Glycerin", "Niacinamide", "Citrullus Lanatus Extract", "Sodium Hyaluronate", "Betaine", "Moringa Oleifera Seed Oil", "Propanediol", "Dimethicone", "Phenoxyethanol", "Ethylhexylglycerin", "Carbomer", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Strawberry Smooth BHA + AHA Salicylic Acid Serum", brand: "Glow Recipe",
                    barcode: "0810007080024",
                    ingredients: ["Aqua", "Glycerin", "Salicylic Acid", "Mandelic Acid", "Fragaria Ananassa Fruit Extract", "Niacinamide", "Sodium Hyaluronate", "Allantoin", "Betaine", "Propanediol", "Phenoxyethanol", "Ethylhexylglycerin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Plum Plump Hyaluronic Acid Serum", brand: "Glow Recipe",
                    barcode: "0810007080031",
                    ingredients: ["Aqua", "Glycerin", "Sodium Hyaluronate", "Prunus Domestica Fruit Extract", "Silk Extract", "Betaine", "Polyglutamic Acid", "Tremella Fuciformis Extract", "Propanediol", "Allantoin", "Phenoxyethanol", "Ethylhexylglycerin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Summer Fridays
            Product(id: UUID().uuidString, name: "Jet Lag Mask", brand: "Summer Fridays",
                    barcode: "0850003644011",
                    ingredients: ["Aqua", "Glycerin", "Squalane", "Niacinamide", "Sodium Hyaluronate", "Aloe Barbadensis Leaf Juice", "Chestnut Extract", "Apricot Kernel Oil", "Cetearyl Alcohol", "Dimethicone", "Phenoxyethanol", "Tocopherol", "Allantoin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "CC Me Vitamin C Serum", brand: "Summer Fridays",
                    barcode: "0850003644028",
                    ingredients: ["Aqua", "Ascorbic Acid", "Glycerin", "Propanediol", "Niacinamide", "Sodium Hyaluronate", "Ferulic Acid", "Vitamin E", "Kakadu Plum Extract", "Phenoxyethanol", "Ethylhexylglycerin", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Laneige
            Product(id: UUID().uuidString, name: "Water Sleeping Mask", brand: "Laneige",
                    barcode: "8801042477483",
                    ingredients: ["Aqua", "Butylene Glycol", "Glycerin", "Dimethicone", "Trehalose", "Prunus Armeniaca Kernel Extract", "Rosa Canina Fruit Extract", "Nelumbo Nucifera Flower Extract", "Sodium Hyaluronate", "Cetearyl Alcohol", "Phenoxyethanol", "Carbomer", "Ethylhexylglycerin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Lip Sleeping Mask Berry", brand: "Laneige",
                    barcode: "8801042477490",
                    ingredients: ["Diisostearyl Malate", "Hydrogenated Polyisobutene", "Phytosteryl/Isostearyl/Cetyl/Stearyl/Behenyl Dimer Dilinoleate", "Shea Butter", "Sweet Orange Oil", "Berry Extract", "Coconut Oil", "Vitamin C", "Glycerin", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Sol de Janeiro
            Product(id: UUID().uuidString, name: "Brazilian Bum Bum Cream", brand: "Sol de Janeiro",
                    barcode: "0860003830017",
                    ingredients: ["Aqua", "Glycerin", "Cetearyl Alcohol", "Cupuacu Butter", "Acai Extract", "Coconut Oil", "Caffeine", "Guarana Seed Extract", "Sodium Hyaluronate", "Dimethicone", "Phenoxyethanol", "Parfum", "Tocopherol", "BHT"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Charlotte Tilbury
            Product(id: UUID().uuidString, name: "Magic Cream Moisturizer", brand: "Charlotte Tilbury",
                    barcode: "5060332320011",
                    ingredients: ["Aqua", "Glycerin", "Dimethicone", "Cetearyl Alcohol", "Butyrospermum Parkii Butter", "Rosehip Seed Oil", "Aloe Vera Extract", "Hyaluronic Acid", "Vitamin C", "Vitamin E", "BioNymph Peptide Complex", "Phenoxyethanol", "Parfum", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Fenty Skin
            Product(id: UUID().uuidString, name: "Total Cleans'r Remove-It-All Cleanser", brand: "Fenty Skin",
                    barcode: "0850017076013",
                    ingredients: ["Aqua", "Glycerin", "Cocamidopropyl Betaine", "Sodium Cocoyl Isethionate", "Barbados Cherry Extract", "Fig Extract", "Rambutan Leaf Extract", "Niacinamide", "Allantoin", "Phenoxyethanol", "Citric Acid"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Fat Water Niacinamide Pore-Refining Toner Serum", brand: "Fenty Skin",
                    barcode: "0850017076020",
                    ingredients: ["Aqua", "Niacinamide", "Glycerin", "Witch Hazel Water", "Barbados Cherry Extract", "Salicylic Acid", "Hyaluronic Acid", "Allantoin", "Panthenol", "Phenoxyethanol", "Ethylhexylglycerin", "Citric Acid"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Rare Beauty (Selena Gomez)
            Product(id: UUID().uuidString, name: "Always An Optimist Pore Diffusing Primer", brand: "Rare Beauty",
                    barcode: "0194320005017",
                    ingredients: ["Aqua", "Dimethicone", "Glycerin", "Niacinamide", "Lotus Extract", "Gardenia Extract", "White Water Lily Extract", "Sodium Hyaluronate", "Allantoin", "Phenoxyethanol", "Silica", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Paula's Choice
            Product(id: UUID().uuidString, name: "Skin Perfecting 2% BHA Liquid Exfoliant", brand: "Paula's Choice",
                    barcode: "0655439077101",
                    ingredients: ["Aqua", "Methylpropanediol", "Butylene Glycol", "Salicylic Acid", "Polysorbate 20", "Green Tea Extract", "Methylcellulose", "Sodium Hydroxide", "Tetrasodium EDTA"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "10% Azelaic Acid Booster", brand: "Paula's Choice",
                    barcode: "0655439077118",
                    ingredients: ["Aqua", "Azelaic Acid", "Dimethicone", "Cetearyl Alcohol", "Glycerin", "Salicylic Acid", "Adenosine", "Allantoin", "Boerhavia Diffusa Root Extract", "Phenoxyethanol", "Sodium Hydroxide"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Supergoop
            Product(id: UUID().uuidString, name: "Unseen Sunscreen SPF 40", brand: "Supergoop!",
                    barcode: "0867405000201",
                    ingredients: ["Avobenzone", "Homosalate", "Octisalate", "Octocrylene", "Dimethicone", "Isododecane", "Silica", "Meadowfoam Seed Oil", "Frankincense Extract", "Red Algae Extract", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Glowscreen SPF 40", brand: "Supergoop!",
                    barcode: "0867405000218",
                    ingredients: ["Avobenzone", "Homosalate", "Octisalate", "Octocrylene", "Aqua", "Glycerin", "Niacinamide", "Sodium Hyaluronate", "Dimethicone", "Cocoa Peptides", "Phenoxyethanol", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Youth to the People
            Product(id: UUID().uuidString, name: "Superfood Cleanser", brand: "Youth to the People",
                    barcode: "0816498020101",
                    ingredients: ["Aqua", "Sodium Cocoyl Glutamate", "Cocamidopropyl Hydroxysultaine", "Glycerin", "Spinach Leaf Extract", "Kale Extract", "Green Tea Extract", "Alfalfa Extract", "Panthenol", "Allantoin", "Phenoxyethanol", "Citric Acid"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Superberry Hydrate + Glow Dream Mask", brand: "Youth to the People",
                    barcode: "0816498020118",
                    ingredients: ["Aqua", "Glycerin", "Squalane", "Maqui Berry Extract", "Goji Berry Extract", "Prickly Pear Extract", "Sodium Hyaluronate", "Vitamin C", "Vitamin E", "Dimethicone", "Cetearyl Alcohol", "Phenoxyethanol", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Fresh
            Product(id: UUID().uuidString, name: "Soy Face Cleanser", brand: "Fresh",
                    barcode: "0809280100109",
                    ingredients: ["Aqua", "Sodium Lauroyl Glutamate", "Glycerin", "Soy Proteins", "Rosewater", "Cucumber Extract", "Borage Seed Oil", "Allantoin", "Cocamidopropyl Betaine", "Phenoxyethanol", "Citric Acid"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Rose Deep Hydration Face Cream", brand: "Fresh",
                    barcode: "0809280100116",
                    ingredients: ["Aqua", "Glycerin", "Rosa Damascena Flower Water", "Dimethicone", "Cetearyl Alcohol", "Hyaluronic Acid", "Rose Hip Seed Oil", "Angelica Leaf Extract", "Time-Release Vitamin E", "Phenoxyethanol", "Tocopherol", "Parfum"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Clinique
            Product(id: UUID().uuidString, name: "Moisture Surge 100H Auto-Replenishing Hydrator", brand: "Clinique",
                    barcode: "0020714933890",
                    ingredients: ["Aqua", "Dimethicone", "Glycerin", "Butylene Glycol", "Aloe Vera Bioferment", "Hyaluronic Acid", "Caffeine", "Sorbitol", "Trehalose", "Cetearyl Alcohol", "Phenoxyethanol", "Carbomer", "Allantoin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Dramatically Different Moisturizing Lotion+", brand: "Clinique",
                    barcode: "0020714933906",
                    ingredients: ["Aqua", "Mineral Oil", "Glycerin", "Petrolatum", "Stearic Acid", "Cetyl Alcohol", "Glyceryl Stearate", "Sesamum Indicum Seed Oil", "Urea", "Sodium Hyaluronate", "Tocopherol", "Phenoxyethanol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - SK-II
            Product(id: UUID().uuidString, name: "Facial Treatment Essence", brand: "SK-II",
                    barcode: "4979006053906",
                    ingredients: ["Galactomyces Ferment Filtrate (Pitera)", "Butylene Glycol", "Pentylene Glycol", "Aqua", "Sodium Benzoate", "Methylparaben", "Sorbic Acid"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Tower 28
            Product(id: UUID().uuidString, name: "SOS Daily Rescue Facial Spray", brand: "Tower 28",
                    barcode: "0850017076044",
                    ingredients: ["Aqua", "Sodium Hypochlorite"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Kosas
            Product(id: UUID().uuidString, name: "Cloud Set Baked Setting & Smoothing Powder", brand: "Kosas",
                    barcode: "0860003830031",
                    ingredients: ["Silica", "Dimethicone", "Lauroyl Lysine", "Zinc Stearate", "Hyaluronic Acid", "Bakuchiol", "Meadowfoam Seed Oil", "Argan Oil", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - ILIA
            Product(id: UUID().uuidString, name: "Super Serum Skin Tint SPF 40", brand: "ILIA",
                    barcode: "0818107020101",
                    ingredients: ["Zinc Oxide", "Titanium Dioxide", "Aqua", "Squalane", "Niacinamide", "Sodium Hyaluronate", "Aloe Vera Extract", "Rose Hip Seed Oil", "Malachite Extract", "Dimethicone", "Phenoxyethanol", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Herbivore
            Product(id: UUID().uuidString, name: "Blue Tansy Resurfacing Clarity Mask", brand: "Herbivore",
                    barcode: "0857210006017",
                    ingredients: ["Aqua", "White Willow Bark Extract", "Fruit Enzymes", "Blue Tansy Oil", "Aloe Vera Leaf Juice", "Glycerin", "Sodium Hyaluronate", "Kaolin", "Phenoxyethanol", "Ethylhexylglycerin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Bakuchiol Retinol Alternative Serum", brand: "Herbivore",
                    barcode: "0857210006024",
                    ingredients: ["Squalane", "Bakuchiol", "Borage Seed Oil", "Kale Extract", "Omega Fatty Acids", "Tocopherol", "Rosemary Leaf Extract"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Farmacy
            Product(id: UUID().uuidString, name: "Green Clean Makeup Meltaway Cleansing Balm", brand: "Farmacy",
                    barcode: "0850003644035",
                    ingredients: ["Ethylhexyl Palmitate", "Polyethylene", "Sunflower Seed Oil", "Moringa Seed Oil", "Ginger Root Oil", "Turmeric Root Extract", "Echinacea Extract", "Papaya Fruit Extract", "Tocopherol", "Glycerin"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Honey Potion Renewing Antioxidant Hydration Mask", brand: "Farmacy",
                    barcode: "0850003644042",
                    ingredients: ["Honey", "Glycerin", "Propanediol", "Echinacea GreenEnvy Complex", "Royal Jelly", "Propolis Extract", "Honey Extract", "Vitamin B3", "Vitamin B5", "Sodium Hyaluronate", "Phenoxyethanol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Origins
            Product(id: UUID().uuidString, name: "GinZing Energy-Boosting Gel Moisturizer", brand: "Origins",
                    barcode: "0717334200111",
                    ingredients: ["Aqua", "Dimethicone", "Glycerin", "Caffeine", "Panax Ginseng Root Extract", "Magnolia Extract", "Sodium Hyaluronate", "Niacinamide", "Butylene Glycol", "Phenoxyethanol", "Carbomer", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Caudalie
            Product(id: UUID().uuidString, name: "Vinoperfect Radiance Serum", brand: "Caudalie",
                    barcode: "3522930001539",
                    ingredients: ["Aqua", "Glycerin", "Squalane", "Viniferine", "Niacinamide", "Olive Squalane", "Hyaluronic Acid", "Bisabolol", "Propanediol", "Phenoxyethanol", "Ethylhexylglycerin", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Vinosource-Hydra S.O.S Intense Moisturizing Cream", brand: "Caudalie",
                    barcode: "3522930001546",
                    ingredients: ["Aqua", "Glycerin", "Grape Water", "Squalane", "Shea Butter", "Organic Grape Seed Oil", "Hyaluronic Acid", "Vinolevure", "Cetearyl Alcohol", "Dimethicone", "Phenoxyethanol", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Beauty Elixir", brand: "Caudalie",
                    barcode: "3522930001553",
                    ingredients: ["Aqua", "Grape Extract", "Rosemary Extract", "Rose Extract", "Orange Blossom Extract", "Peppermint Oil", "Benzoin Resin Extract", "Myrrh Extract", "Glycerin", "Phenoxyethanol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Darphin
            Product(id: UUID().uuidString, name: "Intral Redness Relief Soothing Serum", brand: "Darphin",
                    barcode: "0882381048976",
                    ingredients: ["Aqua", "Glycerin", "Hawthorn Extract", "Chamomile Extract", "Peony Extract", "Licorice Root Extract", "Grape Seed Extract", "Dimethicone", "Sodium Hyaluronate", "Allantoin", "Bisabolol", "Phenoxyethanol", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Hydraskin Light Gel Cream", brand: "Darphin",
                    barcode: "0882381048983",
                    ingredients: ["Aqua", "Glycerin", "Dimethicone", "Watermelon Extract", "Apple Extract", "Haberlea Rhodopensis Extract", "Sodium Hyaluronate", "Allantoin", "Cetearyl Alcohol", "Phenoxyethanol", "Carbomer", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Bioderma
            Product(id: UUID().uuidString, name: "Sensibio H2O Micellar Water", brand: "Bioderma",
                    barcode: "3401345935571",
                    ingredients: ["Aqua", "PEG-6 Caprylic/Capric Glycerides", "Fructooligosaccharides", "Mannitol", "Xylitol", "Rhamnose", "Cucumis Sativus Fruit Extract", "Propylene Glycol", "Cetrimonium Bromide", "Disodium EDTA"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Atoderm Intensive Baume", brand: "Bioderma",
                    barcode: "3401345935588",
                    ingredients: ["Aqua", "Glycerin", "Helianthus Annuus Seed Oil", "Canola Oil", "Shea Butter", "Niacinamide", "Zinc Gluconate", "Cetearyl Alcohol", "Dimethicone", "Allantoin", "Phenoxyethanol", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Avene
            Product(id: UUID().uuidString, name: "Cicalfate+ Restorative Protective Cream", brand: "Avene",
                    barcode: "3282770100150",
                    ingredients: ["Avene Thermal Spring Water", "Mineral Oil", "Glycerin", "Copper Sulfate", "Zinc Sulfate", "Sucralfate", "Cetearyl Alcohol", "Dimethicone", "Beeswax", "Phenoxyethanol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Tolerance Extreme Cream", brand: "Avene",
                    barcode: "3282770100167",
                    ingredients: ["Avene Thermal Spring Water", "Squalane", "Behenyl Alcohol", "Caprylic/Capric Triglyceride", "Glycerin", "Sodium Acrylates Copolymer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Vichy
            Product(id: UUID().uuidString, name: "Mineral 89 Hyaluronic Acid Serum", brand: "Vichy",
                    barcode: "3337875543545",
                    ingredients: ["Aqua", "Vichy Mineralizing Water", "Glycerin", "Sodium Hyaluronate", "Dimethicone", "Caprylyl Glycol", "Carbomer", "Citric Acid", "Sodium Hydroxide"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Normaderm PhytoAction Daily Deep Cleansing Gel", brand: "Vichy",
                    barcode: "3337875543552",
                    ingredients: ["Aqua", "Sodium Laureth Sulfate", "Glycerin", "Coco-Betaine", "Salicylic Acid", "Zinc PCA", "Copper Gluconate", "Vichy Mineralizing Water", "Citric Acid", "Phenoxyethanol", "Sodium Hydroxide"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Embryolisse
            Product(id: UUID().uuidString, name: "Lait-Creme Concentre", brand: "Embryolisse",
                    barcode: "3350900000066",
                    ingredients: ["Aqua", "Stearic Acid", "Glycerin", "Paraffinum Liquidum", "Triethanolamine", "Shea Butter", "Beeswax", "Aloe Vera Extract", "Soy Proteins", "Cetyl Palmitate", "Phenoxyethanol", "Methylparaben"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Nuxe
            Product(id: UUID().uuidString, name: "Huile Prodigieuse Multi-Purpose Dry Oil", brand: "Nuxe",
                    barcode: "3264680003820",
                    ingredients: ["Macadamia Ternifolia Seed Oil", "Corylus Avellana Seed Oil", "Tsubaki Seed Oil", "Argan Oil", "Borage Seed Oil", "Sweet Almond Oil", "Caprylic/Capric Triglyceride", "Tocopherol", "Parfum", "Rosmarinus Officinalis Leaf Extract"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            Product(id: UUID().uuidString, name: "Creme Fraiche de Beaute 48H Moisturising Cream", brand: "Nuxe",
                    barcode: "3264680003837",
                    ingredients: ["Aqua", "Glycerin", "Sweet Almond Oil", "Dimethicone", "Algae Extract", "Jasmine Flower Extract", "Sodium Hyaluronate", "Cetearyl Alcohol", "Shea Butter", "Phenoxyethanol", "Parfum", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - SVR
            Product(id: UUID().uuidString, name: "Sebiaclear Serum", brand: "SVR",
                    barcode: "3401381330187",
                    ingredients: ["Aqua", "Niacinamide", "Gluconolactone", "Glycerin", "Salicylic Acid", "Zinc PCA", "Allantoin", "Propanediol", "Phenoxyethanol", "Sodium Hydroxide", "Carbomer"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Filorga
            Product(id: UUID().uuidString, name: "Time-Filler Absolute Wrinkle Correction Cream", brand: "Filorga",
                    barcode: "3401360262423",
                    ingredients: ["Aqua", "Glycerin", "Dimethicone", "Hyaluronic Acid", "Peptide Complex", "Collagen", "Shea Butter", "Cetearyl Alcohol", "Niacinamide", "Phenoxyethanol", "Parfum", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),

            // MARK: - Uriage
            Product(id: UUID().uuidString, name: "Bariederm Cica-Cream SPF50+", brand: "Uriage",
                    barcode: "3661434007200",
                    ingredients: ["Aqua", "Uriage Thermal Water", "Glycerin", "Copper Sulfate", "Zinc Sulfate", "Centella Asiatica Extract", "Hyaluronic Acid", "Dimethicone", "Titanium Dioxide", "Phenoxyethanol", "Tocopherol"],
                    photoURL: nil, addedBy: "local", createdAt: Date()),
        ]

        for product in mockProducts {
            _ = saveProduct(product)
        }

        defaults.set(true, forKey: mockLoadedKey)
    }
}
