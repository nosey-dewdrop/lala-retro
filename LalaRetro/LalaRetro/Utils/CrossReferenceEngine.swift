import Foundation

struct CrossReferenceEngine {
    /// Cross-references reactions and products to find suspect ingredients.
    /// An ingredient is suspicious if it appears in products across 2+ separate reactions.
    static func findSuspects(
        reactions: [UserReaction],
        products: [Product]
    ) -> [SuspectResult] {
        guard reactions.count >= 2 else { return [] }

        let productMap = Dictionary(uniqueKeysWithValues:
            products.compactMap { p in p.id.map { ($0, p) } }
        )

        // For each reaction, collect the union of ingredients from all products in that reaction
        var ingredientReactionCount: [String: Set<String>] = [:]  // ingredient -> set of reaction IDs
        var ingredientProducts: [String: Set<String>] = [:]       // ingredient -> set of product IDs

        for reaction in reactions {
            guard let reactionId = reaction.id else { continue }
            var reactionIngredients = Set<String>()

            for productId in reaction.productIds {
                guard let product = productMap[productId] else { continue }
                for ingredient in product.ingredients {
                    let normalized = ingredient.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    reactionIngredients.insert(normalized)
                    ingredientProducts[normalized, default: []].insert(productId)
                }
            }

            for ingredient in reactionIngredients {
                ingredientReactionCount[ingredient, default: []].insert(reactionId)
            }
        }

        // Filter: only ingredients found in 2+ reactions
        let suspects = ingredientReactionCount
            .filter { $0.value.count >= 2 }
            .map { (ingredient, reactionIds) in
                SuspectResult(
                    ingredientName: ingredient,
                    occurrenceCount: reactionIds.count,
                    totalReactions: reactions.count,
                    foundInProducts: Array(ingredientProducts[ingredient] ?? [])
                )
            }
            .sorted { a, b in
                if a.occurrenceCount != b.occurrenceCount {
                    return a.occurrenceCount > b.occurrenceCount
                }
                return a.ingredientName < b.ingredientName
            }

        return suspects
    }
}
