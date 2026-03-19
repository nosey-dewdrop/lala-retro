import Foundation

@Observable
class ReactionViewModel {
    var selectedProductIds: Set<String> = []
    var selectedReactions: Set<ReactionType> = []
    var notes = ""
    var isSaving = false
    var userProducts: [Product] = []

    func loadUserProducts() {
        userProducts = LocalStorageService.shared.getAllProducts()
    }

    func toggleProduct(_ id: String) {
        if selectedProductIds.contains(id) {
            selectedProductIds.remove(id)
        } else {
            selectedProductIds.insert(id)
        }
    }

    func toggleReaction(_ type: ReactionType) {
        if selectedReactions.contains(type) {
            selectedReactions.remove(type)
        } else {
            selectedReactions.insert(type)
        }
    }

    var canSave: Bool {
        !selectedProductIds.isEmpty && !selectedReactions.isEmpty
    }

    func save() -> Bool {
        guard canSave else { return false }
        isSaving = true

        let reaction = UserReaction(
            productIds: Array(selectedProductIds),
            reactionTypes: Array(selectedReactions),
            date: Date(),
            notes: notes.isEmpty ? nil : notes
        )

        LocalStorageService.shared.saveReaction(reaction)
        isSaving = false
        return true
    }

    func reset() {
        selectedProductIds = []
        selectedReactions = []
        notes = ""
    }
}
