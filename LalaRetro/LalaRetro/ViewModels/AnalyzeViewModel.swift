import Foundation

@Observable
class AnalyzeViewModel {
    var suspects: [SuspectResult] = []
    var reactions: [UserReaction] = []
    var isLoading = false
    var hasEnoughData: Bool { reactions.count >= 2 }
    var reactionCount: Int { reactions.count }

    func analyze() {
        isLoading = true

        reactions = LocalStorageService.shared.getReactions()

        let allProductIds = Set(reactions.flatMap { $0.productIds })
        let products = allProductIds.compactMap { LocalStorageService.shared.getProduct(id: $0) }

        suspects = CrossReferenceEngine.findSuspects(reactions: reactions, products: products)
        isLoading = false
    }
}
