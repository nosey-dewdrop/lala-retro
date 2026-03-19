import Foundation

struct SuspectResult: Identifiable {
    var id: String { ingredientName }
    var ingredientName: String
    var occurrenceCount: Int
    var totalReactions: Int
    var foundInProducts: [String]

    var suspicionScore: Double {
        guard totalReactions > 0 else { return 0 }
        return Double(occurrenceCount) / Double(totalReactions)
    }

    var percentageText: String {
        "\(occurrenceCount)/\(totalReactions)"
    }
}
