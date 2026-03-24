import Foundation

class InteractionService: @unchecked Sendable {
    static let shared = InteractionService()
    private init() {}

    /// Check interactions between a product's ingredients and all other products the user has
    func checkInteractions(for product: Product) -> [InteractionResult] {
        let allProducts = LocalStorageService.shared.getAllProducts()
        let otherProducts = allProducts.filter { $0.id != product.id }

        var results: [InteractionResult] = []
        let productIngredients = normalizedSet(product.ingredients)

        for other in otherProducts {
            let otherIngredients = normalizedSet(other.ingredients)
            results.append(contentsOf: findInteractions(
                ingredientsA: productIngredients,
                ingredientsB: otherIngredients,
                productNameA: product.name,
                productNameB: other.name
            ))
        }

        results.append(contentsOf: findSelfInteractions(
            ingredients: productIngredients,
            productName: product.name
        ))

        return deduplicateAndSort(results)
    }

    /// Check interactions between a set of selected products (routine check)
    func checkRoutineInteractions(products: [Product]) -> [InteractionResult] {
        var results: [InteractionResult] = []

        for i in 0..<products.count {
            let ingredientsA = normalizedSet(products[i].ingredients)

            for j in (i + 1)..<products.count {
                let ingredientsB = normalizedSet(products[j].ingredients)
                results.append(contentsOf: findInteractions(
                    ingredientsA: ingredientsA,
                    ingredientsB: ingredientsB,
                    productNameA: products[i].name,
                    productNameB: products[j].name
                ))
            }

            results.append(contentsOf: findSelfInteractions(
                ingredients: ingredientsA,
                productName: products[i].name
            ))
        }

        return deduplicateAndSort(results)
    }

    // MARK: - Private

    private func normalizedSet(_ ingredients: [String]) -> Set<String> {
        Set(ingredients.map { $0.lowercased().trimmingCharacters(in: .whitespaces) })
    }

    private func findInteractions(
        ingredientsA: Set<String>,
        ingredientsB: Set<String>,
        productNameA: String,
        productNameB: String
    ) -> [InteractionResult] {
        var results: [InteractionResult] = []

        for interaction in IngredientInteractionDatabase.interactions {
            if let a = findMatch(ingredients: ingredientsA, knownNames: interaction.ingredientA),
               let b = findMatch(ingredients: ingredientsB, knownNames: interaction.ingredientB) {
                results.append(InteractionResult(
                    matchedA: a, matchedB: b,
                    productNameA: productNameA, productNameB: productNameB,
                    interaction: interaction
                ))
            }

            if let a = findMatch(ingredients: ingredientsA, knownNames: interaction.ingredientB),
               let b = findMatch(ingredients: ingredientsB, knownNames: interaction.ingredientA) {
                let isDuplicate = results.contains { r in
                    r.matchedA == b && r.matchedB == a &&
                    r.productNameA == productNameA && r.productNameB == productNameB
                }
                if !isDuplicate {
                    results.append(InteractionResult(
                        matchedA: a, matchedB: b,
                        productNameA: productNameA, productNameB: productNameB,
                        interaction: interaction
                    ))
                }
            }
        }

        return results
    }

    private func findSelfInteractions(ingredients: Set<String>, productName: String) -> [InteractionResult] {
        var results: [InteractionResult] = []

        for interaction in IngredientInteractionDatabase.interactions {
            if let a = findMatch(ingredients: ingredients, knownNames: interaction.ingredientA),
               let b = findMatch(ingredients: ingredients, knownNames: interaction.ingredientB),
               a != b {
                results.append(InteractionResult(
                    matchedA: a, matchedB: b,
                    productNameA: productName, productNameB: productName,
                    interaction: interaction
                ))
            }
        }

        return results
    }

    private func findMatch(ingredients: Set<String>, knownNames: [String]) -> String? {
        for known in knownNames {
            let knownLower = known.lowercased()
            // Exact match first (fast path)
            if ingredients.contains(knownLower) {
                return knownLower
            }
            // Substring match (slow path)
            for ingredient in ingredients {
                if ingredient.contains(knownLower) || knownLower.contains(ingredient) {
                    return ingredient
                }
            }
        }
        return nil
    }

    private func deduplicateAndSort(_ results: [InteractionResult]) -> [InteractionResult] {
        var seen = Set<String>()
        var unique: [InteractionResult] = []

        for r in results {
            let key = [r.matchedA, r.matchedB, r.productNameA, r.productNameB].sorted().joined(separator: "|")
            if !seen.contains(key) {
                seen.insert(key)
                unique.append(r)
            }
        }

        return unique.sorted { lhs, rhs in
            let order: [IngredientInteraction.Severity] = [.high, .medium, .low]
            let l = order.firstIndex(of: lhs.interaction.severity) ?? 2
            let r = order.firstIndex(of: rhs.interaction.severity) ?? 2
            return l < r
        }
    }
}
