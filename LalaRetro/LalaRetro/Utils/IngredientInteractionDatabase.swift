import Foundation

enum IngredientInteractionDatabase {

    static let interactions: [IngredientInteraction] = [

        // MARK: - HIGH severity

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "retinoic acid", "tretinoin", "adapalene", "tazarotene", "retinyl palmitate", "retinyl acetate", "hydroxypinacolone retinoate"],
            ingredientB: ["benzoyl peroxide"],
            severity: .high,
            effect: "benzoyl peroxide degrades retinol, making both less effective and increasing irritation",
            advice: "use benzoyl peroxide in the morning and retinol at night"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "retinoic acid", "tretinoin", "adapalene", "tazarotene", "retinyl palmitate", "hydroxypinacolone retinoate"],
            ingredientB: ["glycolic acid", "lactic acid", "mandelic acid", "malic acid", "tartaric acid", "citric acid"],
            severity: .high,
            effect: "AHA acids + retinol together cause excessive exfoliation, leading to redness, peeling, and damaged skin barrier",
            advice: "alternate nights — AHA one night, retinol the next"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "retinoic acid", "tretinoin", "adapalene", "tazarotene", "retinyl palmitate", "hydroxypinacolone retinoate"],
            ingredientB: ["salicylic acid"],
            severity: .high,
            effect: "BHA + retinol together over-exfoliate and dry out the skin, risking barrier damage",
            advice: "use salicylic acid in the morning and retinol at night"
        ),

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid", "ascorbyl glucoside", "sodium ascorbyl phosphate", "ascorbyl tetraisopalmitate", "ethyl ascorbic acid", "3-o-ethyl ascorbic acid"],
            ingredientB: ["benzoyl peroxide"],
            severity: .high,
            effect: "benzoyl peroxide oxidizes vitamin C, making it useless",
            advice: "use them at different times of day — vitamin C morning, benzoyl peroxide evening"
        ),

        IngredientInteraction(
            ingredientA: ["hydroquinone"],
            ingredientB: ["benzoyl peroxide"],
            severity: .high,
            effect: "benzoyl peroxide can cause temporary dark staining when combined with hydroquinone",
            advice: "never layer these — use at completely different times"
        ),

        // MARK: - MEDIUM severity

        IngredientInteraction(
            ingredientA: ["niacinamide", "nicotinamide"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .medium,
            effect: "at low pH, niacinamide can convert to niacin causing flushing and redness",
            advice: "wait 15-30 minutes between application, or use niacinamide derivatives that are pH-stable"
        ),

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid", "ascorbyl glucoside", "sodium ascorbyl phosphate"],
            ingredientB: ["glycolic acid", "lactic acid", "mandelic acid"],
            severity: .medium,
            effect: "both are acidic — layering creates an overly acidic environment that can irritate and burn",
            advice: "use vitamin C in the morning and AHA at night"
        ),

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            ingredientB: ["salicylic acid"],
            severity: .medium,
            effect: "both work at low pH but layering can cause dryness and irritation",
            advice: "use vitamin C in the morning and salicylic acid at night"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "tretinoin", "adapalene"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .medium,
            effect: "both are potent actives — layering can overwhelm the skin and cause irritation",
            advice: "use vitamin C in the morning and retinol at night for best results"
        ),

        IngredientInteraction(
            ingredientA: ["glycolic acid", "lactic acid", "mandelic acid"],
            ingredientB: ["salicylic acid"],
            severity: .medium,
            effect: "AHA + BHA together is very aggressive exfoliation — high risk of over-exfoliation",
            advice: "alternate days or use a product that's pre-formulated with both at safe concentrations"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene", "tazarotene"],
            ingredientB: ["azelaic acid"],
            severity: .medium,
            effect: "both increase cell turnover — together they may cause excessive dryness and peeling",
            advice: "start by alternating nights, only combine once skin is fully adapted"
        ),

        IngredientInteraction(
            ingredientA: ["copper peptides", "copper tripeptide-1", "ghk-cu"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .medium,
            effect: "copper ions oxidize vitamin C, reducing its effectiveness",
            advice: "use at different times of day"
        ),

        IngredientInteraction(
            ingredientA: ["copper peptides", "copper tripeptide-1", "ghk-cu"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid", "retinol", "tretinoin"],
            severity: .medium,
            effect: "direct acids and retinoids can destabilize copper peptides, reducing their benefits",
            advice: "use copper peptides separately from actives — different routine steps or times"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene"],
            ingredientB: ["alcohol denat", "sd alcohol", "denatured alcohol", "isopropyl alcohol"],
            severity: .medium,
            effect: "alcohol increases retinol penetration too aggressively, causing irritation and dryness",
            advice: "avoid alcohol-based toners or products in the same routine as retinol"
        ),

        // MARK: - LOW severity

        IngredientInteraction(
            ingredientA: ["hyaluronic acid", "sodium hyaluronate"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "acids lower pH which slightly reduces hyaluronic acid's hydrating ability",
            advice: "apply acid first, wait a few minutes, then apply hyaluronic acid"
        ),

        IngredientInteraction(
            ingredientA: ["niacinamide", "nicotinamide"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHA's low pH can reduce niacinamide effectiveness and cause mild flushing",
            advice: "wait 10-15 minutes between them, or use in separate routines"
        ),

        IngredientInteraction(
            ingredientA: ["alpha arbutin", "arbutin"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHA can destabilize arbutin at very low pH, reducing its brightening effect",
            advice: "apply arbutin after AHA has absorbed, or use in separate routines"
        ),

        IngredientInteraction(
            ingredientA: ["zinc oxide", "titanium dioxide"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .low,
            effect: "mineral sunscreen can slightly reduce vitamin C absorption",
            advice: "apply vitamin C first and let it fully absorb before sunscreen"
        ),

        IngredientInteraction(
            ingredientA: ["petroleum", "petrolatum", "mineral oil", "paraffinum liquidum"],
            ingredientB: ["retinol", "retinal", "tretinoin", "niacinamide", "hyaluronic acid", "sodium hyaluronate"],
            severity: .low,
            effect: "heavy occlusives applied before actives create a barrier that blocks absorption",
            advice: "always apply actives first, then seal with occlusive as the last step"
        ),
    ]
}
