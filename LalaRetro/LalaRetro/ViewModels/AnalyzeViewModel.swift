import Foundation

@Observable
class AnalyzeViewModel {
    var suspects: [SuspectResult] = []
    var reactions: [UserReaction] = []
    var isLoading = false
    var hasEnoughData: Bool { reactions.count >= 2 }
    var reactionCount: Int { reactions.count }

    // Routine check
    var allProducts: [Product] = []
    var selectedRoutineIds: Set<String> = []
    var routineInteractions: [InteractionResult] = []
    var hasCheckedRoutine = false
    var isCheckingRoutine = false

    func analyze() {
        isLoading = true
        reactions = LocalStorageService.shared.getReactions()
        let allProductIds = Set(reactions.flatMap { $0.productIds })
        let products = allProductIds.compactMap { LocalStorageService.shared.getProduct(id: $0) }
        suspects = CrossReferenceEngine.findSuspects(reactions: reactions, products: products)
        isLoading = false
    }

    func loadProducts() {
        allProducts = LocalStorageService.shared.getAllProducts()
    }

    func toggleRoutineProduct(_ product: Product) {
        guard let id = product.id else { return }
        if selectedRoutineIds.contains(id) {
            selectedRoutineIds.remove(id)
        } else {
            selectedRoutineIds.insert(id)
        }
        hasCheckedRoutine = false
        routineInteractions = []
    }

    @MainActor
    func checkRoutine() async {
        isCheckingRoutine = true
        let selected = allProducts.filter { selectedRoutineIds.contains($0.id ?? "") }
        let result = await Task.detached {
            InteractionService.shared.checkRoutineInteractions(products: selected)
        }.value
        routineInteractions = result
        hasCheckedRoutine = true
        isCheckingRoutine = false
    }
}
