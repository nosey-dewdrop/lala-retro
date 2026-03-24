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

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "tretinoin", "adapalene", "tazarotene", "hydroxypinacolone retinoate"],
            ingredientB: ["retinol", "retinal", "retinaldehyde", "tretinoin", "adapalene", "tazarotene", "hydroxypinacolone retinoate"],
            severity: .high,
            effect: "stacking multiple retinoids multiplies irritation — redness, peeling, and serious barrier damage",
            advice: "pick one retinoid and stick with it, never layer two retinoid products"
        ),

        IngredientInteraction(
            ingredientA: ["hydroquinone"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .high,
            effect: "acids increase hydroquinone penetration unpredictably, risking irritation and rebound hyperpigmentation",
            advice: "use hydroquinone alone or only as prescribed by a dermatologist with acids"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene", "tazarotene"],
            ingredientB: ["kojic acid"],
            severity: .high,
            effect: "both are strong irritants — together they can cause severe dryness, peeling, and sensitization",
            advice: "use on alternate nights, never in the same routine"
        ),

        IngredientInteraction(
            ingredientA: ["glycolic acid", "lactic acid", "mandelic acid", "salicylic acid"],
            ingredientB: ["glycolic acid", "lactic acid", "mandelic acid", "salicylic acid"],
            severity: .high,
            effect: "layering multiple acid products destroys the skin barrier — extreme irritation, burning, peeling",
            advice: "use only one acid product per routine, alternate if you want to use different acids"
        ),

        IngredientInteraction(
            ingredientA: ["benzoyl peroxide"],
            ingredientB: ["glycolic acid", "lactic acid", "mandelic acid"],
            severity: .high,
            effect: "benzoyl peroxide + AHA is extremely drying and irritating, high risk of chemical burn",
            advice: "use on different days or different times of day with moisturizer buffer"
        ),

        IngredientInteraction(
            ingredientA: ["hydroquinone"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .high,
            effect: "both are potent and irritating — together they dramatically increase redness and peeling risk",
            advice: "only combine under dermatologist supervision with careful monitoring"
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

        IngredientInteraction(
            ingredientA: ["benzoyl peroxide"],
            ingredientB: ["salicylic acid"],
            severity: .medium,
            effect: "both are drying and anti-acne — layering doubles the dryness and irritation",
            advice: "use benzoyl peroxide as spot treatment and salicylic acid as cleanser, or alternate days"
        ),

        IngredientInteraction(
            ingredientA: ["tea tree oil", "melaleuca alternifolia"],
            ingredientB: ["retinol", "retinal", "tretinoin", "adapalene"],
            severity: .medium,
            effect: "tea tree oil is a natural irritant that amplifies retinoid sensitivity",
            advice: "use tea tree oil in the morning and retinol at night"
        ),

        IngredientInteraction(
            ingredientA: ["tea tree oil", "melaleuca alternifolia"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "both are strong antimicrobials that together over-dry and irritate the skin",
            advice: "pick one — they target the same concerns"
        ),

        IngredientInteraction(
            ingredientA: ["witch hazel", "hamamelis virginiana"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "salicylic acid"],
            severity: .medium,
            effect: "witch hazel is astringent and drying — amplifies irritation from actives",
            advice: "avoid witch hazel toners when using strong actives"
        ),

        IngredientInteraction(
            ingredientA: ["lemon extract", "citrus limon", "lime extract", "citrus aurantifolia", "grapefruit extract", "citrus paradisi"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "lactic acid", "salicylic acid"],
            severity: .medium,
            effect: "citrus extracts are phototoxic and irritating — combining with actives increases sensitivity and burn risk",
            advice: "avoid citrus-containing products when using actives, especially before sun exposure"
        ),

        IngredientInteraction(
            ingredientA: ["sulfur"],
            ingredientB: ["retinol", "retinal", "tretinoin", "adapalene"],
            severity: .medium,
            effect: "sulfur is drying and can increase retinoid irritation significantly",
            advice: "use sulfur as a spot treatment only, away from retinoid application areas"
        ),

        IngredientInteraction(
            ingredientA: ["sulfur"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "both are strong drying agents — together they can cause severe dryness, flaking, and irritation",
            advice: "do not layer — alternate days if you need both"
        ),

        IngredientInteraction(
            ingredientA: ["emu oil", "rosehip oil", "argan oil", "jojoba oil", "squalane", "marula oil"],
            ingredientB: ["niacinamide", "nicotinamide", "hyaluronic acid", "sodium hyaluronate"],
            severity: .medium,
            effect: "oils create a barrier that prevents water-based actives from penetrating properly",
            advice: "apply water-based serums first, wait 2-3 minutes, then apply oil-based products"
        ),

        IngredientInteraction(
            ingredientA: ["vitamin e", "tocopherol", "tocopheryl acetate"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .medium,
            effect: "vitamin E can increase retinol absorption too much in some formulations, causing irritation",
            advice: "use vitamin E in the morning routine and retinol at night"
        ),

        IngredientInteraction(
            ingredientA: ["ferulic acid"],
            ingredientB: ["niacinamide", "nicotinamide"],
            severity: .medium,
            effect: "ferulic acid's low pH can reduce niacinamide effectiveness and cause flushing",
            advice: "use ferulic acid + vitamin C serum in AM, niacinamide in PM"
        ),

        IngredientInteraction(
            ingredientA: ["bakuchiol"],
            ingredientB: ["retinol", "retinal", "tretinoin", "adapalene"],
            severity: .medium,
            effect: "bakuchiol has retinol-like activity — stacking with actual retinoids can over-exfoliate",
            advice: "choose one or the other, bakuchiol is a gentler alternative not a booster"
        ),

        IngredientInteraction(
            ingredientA: ["epidermal growth factor", "egf", "sh-oligopeptide-1"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid", "retinol", "tretinoin"],
            severity: .medium,
            effect: "acids and retinoids degrade growth factor peptides, wasting the most expensive ingredient in your routine",
            advice: "use EGF on its own or with gentle hydrators only"
        ),

        IngredientInteraction(
            ingredientA: ["galactomyces ferment filtrate", "saccharomyces ferment filtrate", "bifida ferment lysate"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "benzoyl peroxide is an oxidizer that can destroy the beneficial compounds in ferment filtrates",
            advice: "use ferment products in AM routine, benzoyl peroxide in PM"
        ),

        IngredientInteraction(
            ingredientA: ["centella asiatica", "madecassoside", "asiaticoside"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .medium,
            effect: "strong AHAs can reduce centella's soothing and healing benefits by lowering skin pH too much",
            advice: "apply centella after acid has fully absorbed, or use in separate routines"
        ),

        IngredientInteraction(
            ingredientA: ["tranexamic acid"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .medium,
            effect: "both can cause dryness and sensitivity — together they increase irritation risk for sensitive skin",
            advice: "introduce slowly, alternate nights until skin adjusts"
        ),

        IngredientInteraction(
            ingredientA: ["snail mucin", "snail secretion filtrate"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .medium,
            effect: "acids can break down the glycoproteins in snail mucin, reducing its hydrating benefits",
            advice: "apply acid first, wait 10-15 minutes, then apply snail mucin"
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

        IngredientInteraction(
            ingredientA: ["silicone", "dimethicone", "cyclomethicone", "cyclopentasiloxane", "dimethiconol"],
            ingredientB: ["hyaluronic acid", "sodium hyaluronate", "niacinamide", "nicotinamide"],
            severity: .low,
            effect: "silicones form a film that can reduce penetration of water-soluble actives applied after",
            advice: "apply water-based serums before silicone-based primers or moisturizers"
        ),

        IngredientInteraction(
            ingredientA: ["ceramide np", "ceramide ap", "ceramide eop", "phytosphingosine"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "acids can slightly disrupt the ceramide barrier layer if applied simultaneously",
            advice: "apply acid first, let absorb for 10 minutes, then apply ceramide moisturizer to rebuild barrier"
        ),

        IngredientInteraction(
            ingredientA: ["squalane", "squalene"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .low,
            effect: "squalane can reduce vitamin C penetration when applied first",
            advice: "apply vitamin C serum first on clean skin, then layer squalane on top"
        ),

        IngredientInteraction(
            ingredientA: ["propolis", "propolis extract"],
            ingredientB: ["salicylic acid"],
            severity: .low,
            effect: "both have anti-inflammatory properties — combining is redundant and may cause mild dryness",
            advice: "choose one for your anti-acne step"
        ),

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .low,
            effect: "vitamin C (pH 2-3) and retinol (pH 5-6) work at different pH levels — effectiveness of both is reduced when layered",
            advice: "vitamin C in the morning, retinol at night — each works best at its own pH"
        ),

        IngredientInteraction(
            ingredientA: ["panthenol", "dexpanthenol", "provitamin b5"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHA's low pH slightly reduces panthenol's barrier-repair effectiveness",
            advice: "apply panthenol 10-15 minutes after acid to maximize both benefits"
        ),

        IngredientInteraction(
            ingredientA: ["allantoin"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "allantoin's soothing effect is reduced at very low pH",
            advice: "apply acid first, then allantoin-rich moisturizer to soothe after"
        ),

        IngredientInteraction(
            ingredientA: ["colloidal oatmeal", "avena sativa"],
            ingredientB: ["glycolic acid", "lactic acid", "retinol", "tretinoin"],
            severity: .low,
            effect: "oatmeal is meant to soothe — mixing with irritating actives sends mixed signals to your skin",
            advice: "use oatmeal products as recovery after active nights, not simultaneously"
        ),

        IngredientInteraction(
            ingredientA: ["honey", "manuka honey", "propolis"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "honey's natural sugars can interfere with AHA exfoliation at the skin surface",
            advice: "use honey masks on non-acid days for maximum benefit from both"
        ),

        IngredientInteraction(
            ingredientA: ["adenosine"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "acids can reduce adenosine stability, diminishing its anti-wrinkle effect",
            advice: "apply adenosine after acid has absorbed, or use in PM routine"
        ),

        IngredientInteraction(
            ingredientA: ["peptides", "palmitoyl tripeptide-1", "palmitoyl tetrapeptide-7", "acetyl hexapeptide-8", "matrixyl"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "acids can break peptide bonds, reducing effectiveness of expensive peptide serums",
            advice: "use peptides and acids in separate routines — acids AM or alternate nights, peptides PM"
        ),

        IngredientInteraction(
            ingredientA: ["peptides", "palmitoyl tripeptide-1", "palmitoyl tetrapeptide-7", "acetyl hexapeptide-8", "matrixyl"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .low,
            effect: "vitamin C's low pH can destabilize peptides and reduce their anti-aging benefits",
            advice: "use vitamin C in AM, peptides in PM for best results from both"
        ),

        IngredientInteraction(
            ingredientA: ["resveratrol"],
            ingredientB: ["benzoyl peroxide"],
            severity: .low,
            effect: "benzoyl peroxide oxidizes resveratrol, neutralizing its antioxidant benefits",
            advice: "use resveratrol in AM, benzoyl peroxide in PM"
        ),

        IngredientInteraction(
            ingredientA: ["glycerin"],
            ingredientB: ["salicylic acid"],
            severity: .low,
            effect: "glycerin can slightly buffer salicylic acid's exfoliating action on oily skin",
            advice: "apply salicylic acid on clean skin first, then glycerin-rich moisturizer after"
        ),

        IngredientInteraction(
            ingredientA: ["sodium lauryl sulfate", "sodium laureth sulfate", "sls", "sles"],
            ingredientB: ["retinol", "retinal", "tretinoin", "niacinamide", "vitamin c", "ascorbic acid"],
            severity: .low,
            effect: "harsh sulfates strip the skin barrier, making actives penetrate more aggressively and causing irritation",
            advice: "switch to a gentle, sulfate-free cleanser when using active ingredients"
        ),

        IngredientInteraction(
            ingredientA: ["alcohol denat", "sd alcohol", "denatured alcohol", "isopropyl alcohol"],
            ingredientB: ["hyaluronic acid", "sodium hyaluronate"],
            severity: .low,
            effect: "alcohol dehydrates the skin while hyaluronic acid tries to hydrate — they work against each other",
            advice: "avoid alcohol-based toners when your routine relies on hyaluronic acid for hydration"
        ),

        IngredientInteraction(
            ingredientA: ["fragrance", "parfum", "linalool", "limonene", "citronellol", "geraniol"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "lactic acid"],
            severity: .low,
            effect: "fragrance compounds are sensitizing — actives make skin more vulnerable to fragrance irritation",
            advice: "choose fragrance-free products when using actives to minimize irritation risk"
        ),

        IngredientInteraction(
            ingredientA: ["essential oils", "lavender oil", "eucalyptus oil", "peppermint oil", "rosemary oil"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "essential oils are natural irritants that compound with active ingredient sensitivity",
            advice: "avoid essential oil products on active nights to reduce irritation"
        ),
    ]
}
