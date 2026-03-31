import Foundation

@Observable
class ProfileViewModel {
    var reactions: [UserReaction] = []
    var suspects: [String] = []
    var isLoading = false

    func load() {
        isLoading = true
        reactions = LocalStorageService.shared.getReactions()
        suspects = LocalStorageService.shared.getSuspects()
        isLoading = false
    }

    func removeSuspect(_ ingredient: String) {
        LocalStorageService.shared.removeSuspect(ingredient)
        suspects.removeAll { $0 == ingredient.lowercased() }
    }

    func addSuspect(_ ingredient: String) {
        LocalStorageService.shared.addSuspect(ingredient)
        if !suspects.contains(ingredient.lowercased()) {
            suspects.append(ingredient.lowercased())
        }
    }

    func deleteReaction(id: String) {
        LocalStorageService.shared.deleteReaction(id: id)
        reactions.removeAll { $0.id == id }
    }

    func getProductName(id: String) -> String? {
        LocalStorageService.shared.getProduct(id: id)?.name
    }
}
