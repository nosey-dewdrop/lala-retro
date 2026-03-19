import Foundation

struct Product: Identifiable, Codable, Hashable {
    var id: String?
    var name: String
    var brand: String
    var barcode: String?
    var ingredients: [String]
    var photoURL: String?
    var addedBy: String
    var createdAt: Date

    static let example = Product(
        id: "example-1",
        name: "CeraVe Moisturizing Cream",
        brand: "CeraVe",
        barcode: "3337875597395",
        ingredients: ["Aqua", "Glycerin", "Cetearyl Alcohol", "Caprylic/Capric Triglyceride", "Cetyl Alcohol", "Ceteareth-20", "Petrolatum", "Potassium Phosphate", "Ceramide NP", "Ceramide AP", "Ceramide EOP", "Carbomer", "Dimethicone", "Behentrimonium Methosulfate", "Sodium Lauroyl Lactylate", "Sodium Hyaluronate", "Cholesterol", "Phenoxyethanol", "Disodium EDTA", "Dipotassium Phosphate", "Tocopherol", "Phytosphingosine", "Xanthan Gum"],
        photoURL: nil,
        addedBy: "local",
        createdAt: Date()
    )
}
