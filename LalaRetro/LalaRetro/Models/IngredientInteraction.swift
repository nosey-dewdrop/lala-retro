import Foundation

struct IngredientInteraction: Identifiable {
    let id = UUID()
    let ingredientA: [String]
    let ingredientB: [String]
    let severity: Severity
    let effect: String
    let advice: String

    enum Severity: String {
        case high = "high"
        case medium = "medium"
        case low = "low"
    }
}

struct InteractionResult: Identifiable {
    let id = UUID()
    let matchedA: String
    let matchedB: String
    let productNameA: String
    let productNameB: String
    let interaction: IngredientInteraction

    var isSameProduct: Bool { productNameA == productNameB }
}
