import Foundation

class InteractionService {
    static let shared = InteractionService()
    private init() {}

    /// Check interactions between a product's ingredients and all other products the user has
    func checkInteractions(for product: Product) -> [InteractionResult] {
        let allProducts = LocalStorageService.shared.getAllProducts()
        let otherProducts = allProducts.filter { $0.id != product.id }

        var results: [InteractionResult] = []
        let productIngredients = Set(product.ingredients.map { $0.lowercased().trimmingCharacters(in: .whitespaces) })

        for other in otherProducts {
            let otherIngredients = Set(other.ingredients.map { $0.lowercased().trimmingCharacters(in: .whitespaces) })

            for interaction in IngredientInteractionDatabase.interactions {
                let matchA = findMatch(ingredients: productIngredients, knownNames: interaction.ingredientA)
                let matchB = findMatch(ingredients: otherIngredients, knownNames: interaction.ingredientB)

                if let a = matchA, let b = matchB {
                    results.append(InteractionResult(
                        matchedA: a,
                        matchedB: b,
                        productName: other.name,
                        interaction: interaction
                    ))
                }

                // Check reverse direction too
                let matchAReverse = findMatch(ingredients: productIngredients, knownNames: interaction.ingredientB)
                let matchBReverse = findMatch(ingredients: otherIngredients, knownNames: interaction.ingredientA)

                if let a = matchAReverse, let b = matchBReverse {
                    let alreadyFound = results.contains { r in
                        r.matchedA == b && r.matchedB == a && r.productName == other.name
                    }
                    if !alreadyFound {
                        results.append(InteractionResult(
                            matchedA: a,
                            matchedB: b,
                            productName: other.name,
                            interaction: interaction
                        ))
                    }
                }
            }
        }

        // Also check within the same product
        for interaction in IngredientInteractionDatabase.interactions {
            let matchA = findMatch(ingredients: productIngredients, knownNames: interaction.ingredientA)
            let matchB = findMatch(ingredients: productIngredients, knownNames: interaction.ingredientB)

            if let a = matchA, let b = matchB {
                results.append(InteractionResult(
                    matchedA: a,
                    matchedB: b,
                    productName: product.name,
                    interaction: interaction
                ))
            }
        }

        return results.sorted { lhs, rhs in
            let severityOrder: [IngredientInteraction.Severity] = [.high, .medium, .low]
            let lhsIndex = severityOrder.firstIndex(of: lhs.interaction.severity) ?? 2
            let rhsIndex = severityOrder.firstIndex(of: rhs.interaction.severity) ?? 2
            return lhsIndex < rhsIndex
        }
    }

    private func findMatch(ingredients: Set<String>, knownNames: [String]) -> String? {
        for known in knownNames {
            let knownLower = known.lowercased()
            for ingredient in ingredients {
                if ingredient == knownLower || ingredient.contains(knownLower) || knownLower.contains(ingredient) {
                    return ingredient
                }
            }
        }
        return nil
    }
}
