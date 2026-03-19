import Foundation

@Observable
class HomeViewModel {
    var searchQuery = ""
    var products: [Product] = []
    var isLoading = false
    var hasSearched = false

    func search() {
        guard !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        isLoading = true
        hasSearched = true
        products = LocalStorageService.shared.searchProducts(query: searchQuery)
        isLoading = false
    }
}
