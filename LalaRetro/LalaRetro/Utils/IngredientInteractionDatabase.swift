import Foundation

// swiftlint:disable file_length type_body_length
enum IngredientInteractionDatabase {

    // Comprehensive ingredient interaction database
    // Sources: dermatological literature, cosmetic chemistry research, clinical studies
    // 100+ known interactions covering retinoids, acids, antioxidants, peptides, ferments,
    // botanical extracts, sunscreens, preservatives, and common skincare actives

    static let interactions: [IngredientInteraction] = [

        // ╔══════════════════════════════════════════════════════╗
        // ║                 HIGH SEVERITY                        ║
        // ║  Can cause damage, burns, or serious irritation      ║
        // ╚══════════════════════════════════════════════════════╝

        // MARK: - Retinoid conflicts (HIGH)

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "retinoic acid", "tretinoin", "adapalene", "tazarotene", "retinyl palmitate", "retinyl acetate", "hydroxypinacolone retinoate", "retinyl linoleate"],
            ingredientB: ["benzoyl peroxide"],
            severity: .high,
            effect: "benzoyl peroxide degrades retinol on contact, making both ingredients useless while maximizing irritation",
            advice: "use benzoyl peroxide in the morning and retinol at night — never in the same routine"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "retinoic acid", "tretinoin", "adapalene", "tazarotene", "retinyl palmitate", "hydroxypinacolone retinoate"],
            ingredientB: ["glycolic acid", "lactic acid", "mandelic acid", "malic acid", "tartaric acid", "citric acid", "phytic acid"],
            severity: .high,
            effect: "AHA acids + retinol together cause excessive exfoliation — redness, peeling, and damaged skin barrier",
            advice: "alternate nights — AHA one night, retinol the next"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "retinoic acid", "tretinoin", "adapalene", "tazarotene", "retinyl palmitate", "hydroxypinacolone retinoate"],
            ingredientB: ["salicylic acid", "betaine salicylate"],
            severity: .high,
            effect: "BHA + retinol together over-exfoliate and dry out the skin, risking barrier damage",
            advice: "use salicylic acid in the morning and retinol at night"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "retinaldehyde", "tretinoin", "adapalene", "tazarotene", "hydroxypinacolone retinoate"],
            ingredientB: ["retinol", "retinal", "retinaldehyde", "tretinoin", "adapalene", "tazarotene", "hydroxypinacolone retinoate"],
            severity: .high,
            effect: "stacking multiple retinoids multiplies irritation — redness, peeling, and serious barrier damage",
            advice: "pick one retinoid and stick with it, never layer two retinoid products"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene", "tazarotene"],
            ingredientB: ["kojic acid"],
            severity: .high,
            effect: "both are strong irritants — together they cause severe dryness, peeling, and sensitization",
            advice: "use on alternate nights, never in the same routine"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene", "tazarotene"],
            ingredientB: ["trichloroacetic acid", "tca"],
            severity: .high,
            effect: "TCA is a strong peel acid — combining with retinoids risks chemical burn and severe damage",
            advice: "stop retinoids at least 1 week before any TCA peel"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene"],
            ingredientB: ["hydrogen peroxide"],
            severity: .high,
            effect: "hydrogen peroxide oxidizes and degrades retinoids while causing extreme irritation on sensitized skin",
            advice: "never combine — these belong in completely different routines"
        ),

        // MARK: - Acid conflicts (HIGH)

        IngredientInteraction(
            ingredientA: ["glycolic acid", "lactic acid", "mandelic acid", "salicylic acid", "phytic acid", "malic acid", "tartaric acid"],
            ingredientB: ["glycolic acid", "lactic acid", "mandelic acid", "salicylic acid", "phytic acid", "malic acid", "tartaric acid"],
            severity: .high,
            effect: "layering multiple acid products destroys the skin barrier — extreme irritation, burning, peeling",
            advice: "use only one acid product per routine, alternate if you want to use different acids"
        ),

        IngredientInteraction(
            ingredientA: ["benzoyl peroxide"],
            ingredientB: ["glycolic acid", "lactic acid", "mandelic acid"],
            severity: .high,
            effect: "benzoyl peroxide + AHA is extremely drying and irritating, high risk of chemical burn on sensitive skin",
            advice: "use on different days or different times of day with moisturizer buffer"
        ),

        IngredientInteraction(
            ingredientA: ["glycolic acid", "lactic acid", "mandelic acid", "salicylic acid"],
            ingredientB: ["trichloroacetic acid", "tca"],
            severity: .high,
            effect: "layering daily acids with peel-strength acids causes severe chemical burns",
            advice: "stop all daily acids at least 3 days before a TCA peel"
        ),

        // MARK: - Vitamin C conflicts (HIGH)

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid", "ascorbyl glucoside", "sodium ascorbyl phosphate", "ascorbyl tetraisopalmitate", "ethyl ascorbic acid", "3-o-ethyl ascorbic acid"],
            ingredientB: ["benzoyl peroxide"],
            severity: .high,
            effect: "benzoyl peroxide oxidizes vitamin C on contact, rendering it completely useless",
            advice: "use vitamin C in the morning, benzoyl peroxide in the evening"
        ),

        // MARK: - Hydroquinone conflicts (HIGH)

        IngredientInteraction(
            ingredientA: ["hydroquinone"],
            ingredientB: ["benzoyl peroxide"],
            severity: .high,
            effect: "benzoyl peroxide causes temporary dark staining when combined with hydroquinone",
            advice: "never layer these — use at completely different times of day"
        ),

        IngredientInteraction(
            ingredientA: ["hydroquinone"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .high,
            effect: "acids increase hydroquinone penetration unpredictably, risking irritation and rebound hyperpigmentation",
            advice: "use hydroquinone alone or only as prescribed by a dermatologist with acids"
        ),

        IngredientInteraction(
            ingredientA: ["hydroquinone"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .high,
            effect: "both are potent and irritating — together they dramatically increase redness and peeling risk",
            advice: "only combine under dermatologist supervision with careful monitoring"
        ),

        IngredientInteraction(
            ingredientA: ["hydroquinone"],
            ingredientB: ["hydrogen peroxide"],
            severity: .high,
            effect: "hydrogen peroxide oxidizes hydroquinone causing severe skin discoloration",
            advice: "never use together under any circumstances"
        ),

        IngredientInteraction(
            ingredientA: ["hydroquinone"],
            ingredientB: ["kojic acid"],
            severity: .high,
            effect: "both are potent tyrosinase inhibitors — stacking risks severe irritation and rebound hyperpigmentation",
            advice: "use one or the other, not both"
        ),

        // MARK: - Prescription conflicts (HIGH)

        IngredientInteraction(
            ingredientA: ["clindamycin"],
            ingredientB: ["erythromycin"],
            severity: .high,
            effect: "clindamycin and erythromycin are antagonistic antibiotics — they cancel each other out",
            advice: "never combine these two topical antibiotics"
        ),

        IngredientInteraction(
            ingredientA: ["diclofenac", "diclofenac sodium"],
            ingredientB: ["retinol", "tretinoin", "glycolic acid", "salicylic acid"],
            severity: .high,
            effect: "diclofenac is an NSAID that increases skin sensitivity — actives amplify irritation risk significantly",
            advice: "do not use actives on areas treated with prescription diclofenac"
        ),

        // ╔══════════════════════════════════════════════════════╗
        // ║                MEDIUM SEVERITY                       ║
        // ║  Reduced effectiveness or notable irritation          ║
        // ╚══════════════════════════════════════════════════════╝

        // MARK: - Niacinamide conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["niacinamide", "nicotinamide"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .medium,
            effect: "at low pH, niacinamide can convert to niacin causing flushing and redness",
            advice: "wait 15-30 minutes between application, or use pH-stable vitamin C derivatives"
        ),

        IngredientInteraction(
            ingredientA: ["niacinamide", "nicotinamide"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "benzoyl peroxide can partially oxidize niacinamide, reducing its brightening and barrier benefits",
            advice: "apply niacinamide first, let absorb 5 minutes, then benzoyl peroxide"
        ),

        // MARK: - Vitamin C conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid", "ascorbyl glucoside", "sodium ascorbyl phosphate"],
            ingredientB: ["glycolic acid", "lactic acid", "mandelic acid"],
            severity: .medium,
            effect: "both are acidic — layering creates an overly acidic environment that can irritate and burn",
            advice: "use vitamin C in the morning and AHA at night"
        ),

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            ingredientB: ["salicylic acid", "betaine salicylate"],
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
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            ingredientB: ["azelaic acid"],
            severity: .medium,
            effect: "both are acidic actives — layering may cause stinging and reduced effectiveness",
            advice: "use vitamin C in AM, azelaic acid in PM"
        ),

        // MARK: - Acid combination conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["glycolic acid", "lactic acid", "mandelic acid"],
            ingredientB: ["salicylic acid", "betaine salicylate"],
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
            ingredientA: ["azelaic acid"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .medium,
            effect: "azelaic acid + AHA together can over-exfoliate and irritate, especially on sensitive skin",
            advice: "alternate days or apply AHA first and azelaic acid 20 minutes later"
        ),

        IngredientInteraction(
            ingredientA: ["benzoyl peroxide"],
            ingredientB: ["salicylic acid", "betaine salicylate"],
            severity: .medium,
            effect: "both are drying and anti-acne — layering doubles the dryness and irritation",
            advice: "use benzoyl peroxide as spot treatment and salicylic acid as cleanser, or alternate days"
        ),

        // MARK: - Copper peptide conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["copper peptides", "copper tripeptide-1", "ghk-cu"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .medium,
            effect: "copper ions oxidize vitamin C, reducing its effectiveness completely",
            advice: "use at different times of day — never in the same routine"
        ),

        IngredientInteraction(
            ingredientA: ["copper peptides", "copper tripeptide-1", "ghk-cu"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid", "retinol", "tretinoin"],
            severity: .medium,
            effect: "direct acids and retinoids can destabilize copper peptides, reducing their benefits",
            advice: "use copper peptides separately from actives — different routine steps or times"
        ),

        IngredientInteraction(
            ingredientA: ["copper peptides", "copper tripeptide-1", "ghk-cu"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "benzoyl peroxide oxidizes copper peptides, making them ineffective",
            advice: "use copper peptides in AM, benzoyl peroxide in PM"
        ),

        IngredientInteraction(
            ingredientA: ["copper peptides", "copper tripeptide-1", "ghk-cu"],
            ingredientB: ["niacinamide", "nicotinamide"],
            severity: .medium,
            effect: "niacinamide can chelate copper ions, reducing copper peptide effectiveness",
            advice: "apply copper peptides and niacinamide in separate routines"
        ),

        // MARK: - Alcohol conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene"],
            ingredientB: ["alcohol denat", "sd alcohol", "denatured alcohol", "isopropyl alcohol"],
            severity: .medium,
            effect: "alcohol increases retinol penetration too aggressively, causing irritation and dryness",
            advice: "avoid alcohol-based toners or products in the same routine as retinol"
        ),

        IngredientInteraction(
            ingredientA: ["glycolic acid", "lactic acid", "salicylic acid"],
            ingredientB: ["alcohol denat", "sd alcohol", "denatured alcohol", "isopropyl alcohol"],
            severity: .medium,
            effect: "alcohol strips the barrier making acid penetration deeper and more irritating",
            advice: "avoid alcohol-based products when using chemical exfoliants"
        ),

        // MARK: - Botanical conflicts (MEDIUM)

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
            ingredientA: ["tea tree oil", "melaleuca alternifolia"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .medium,
            effect: "tea tree oil + acids together cause excessive drying and potential contact dermatitis",
            advice: "use tea tree as spot treatment only, separate from acid application"
        ),

        IngredientInteraction(
            ingredientA: ["witch hazel", "hamamelis virginiana"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "salicylic acid"],
            severity: .medium,
            effect: "witch hazel is astringent and drying — amplifies irritation from actives",
            advice: "avoid witch hazel toners when using strong actives"
        ),

        IngredientInteraction(
            ingredientA: ["lemon extract", "citrus limon", "lime extract", "citrus aurantifolia", "grapefruit extract", "citrus paradisi", "bergamot oil", "citrus bergamia"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "lactic acid", "salicylic acid"],
            severity: .medium,
            effect: "citrus extracts are phototoxic and irritating — combining with actives increases sensitivity and burn risk",
            advice: "avoid citrus-containing products when using actives, especially before sun exposure"
        ),

        IngredientInteraction(
            ingredientA: ["cinnamon extract", "cinnamomum", "cinnamon bark oil"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "salicylic acid"],
            severity: .medium,
            effect: "cinnamon is a known skin sensitizer — amplifies irritation from actives",
            advice: "avoid cinnamon-containing products when using actives"
        ),

        IngredientInteraction(
            ingredientA: ["menthol", "camphor", "peppermint oil", "mentha piperita"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "salicylic acid"],
            severity: .medium,
            effect: "menthol and camphor cause vasodilation — combined with actives this amplifies redness and irritation",
            advice: "avoid cooling/tingling products on active ingredient nights"
        ),

        // MARK: - Sulfur conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["sulfur"],
            ingredientB: ["retinol", "retinal", "tretinoin", "adapalene"],
            severity: .medium,
            effect: "sulfur is drying and increases retinoid irritation significantly",
            advice: "use sulfur as a spot treatment only, away from retinoid application areas"
        ),

        IngredientInteraction(
            ingredientA: ["sulfur"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "both are strong drying agents — together they cause severe dryness, flaking, and irritation",
            advice: "do not layer — alternate days if you need both"
        ),

        IngredientInteraction(
            ingredientA: ["sulfur"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .medium,
            effect: "sulfur + acids is extremely drying and can cause cracking and peeling",
            advice: "alternate days, never layer in the same routine"
        ),

        // MARK: - Oil and occlusive conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["emu oil", "rosehip oil", "argan oil", "jojoba oil", "squalane", "marula oil", "tamanu oil", "hemp seed oil", "grapeseed oil"],
            ingredientB: ["niacinamide", "nicotinamide", "hyaluronic acid", "sodium hyaluronate"],
            severity: .medium,
            effect: "oils create a barrier that prevents water-based actives from penetrating properly",
            advice: "apply water-based serums first, wait 2-3 minutes, then apply oil-based products"
        ),

        // MARK: - Vitamin E conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["vitamin e", "tocopherol", "tocopheryl acetate"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .medium,
            effect: "vitamin E can increase retinol absorption too much in some formulations, causing irritation",
            advice: "use vitamin E in the morning routine and retinol at night"
        ),

        IngredientInteraction(
            ingredientA: ["vitamin e", "tocopherol", "tocopheryl acetate"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "benzoyl peroxide oxidizes vitamin E, neutralizing its antioxidant protection",
            advice: "use vitamin E in AM, benzoyl peroxide in PM"
        ),

        // MARK: - Ferulic acid conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["ferulic acid"],
            ingredientB: ["niacinamide", "nicotinamide"],
            severity: .medium,
            effect: "ferulic acid's low pH reduces niacinamide effectiveness and can cause flushing",
            advice: "use ferulic acid + vitamin C serum in AM, niacinamide in PM"
        ),

        // MARK: - Bakuchiol conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["bakuchiol"],
            ingredientB: ["retinol", "retinal", "tretinoin", "adapalene"],
            severity: .medium,
            effect: "bakuchiol has retinol-like activity — stacking with actual retinoids can over-exfoliate",
            advice: "choose one or the other — bakuchiol is a gentler alternative, not a booster"
        ),

        IngredientInteraction(
            ingredientA: ["bakuchiol"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .medium,
            effect: "bakuchiol + AHA can cause irritation similar to retinol + AHA on sensitive skin",
            advice: "alternate nights if using both"
        ),

        // MARK: - Growth factor conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["epidermal growth factor", "egf", "sh-oligopeptide-1", "sh-polypeptide-1", "rh-egf"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid", "retinol", "tretinoin"],
            severity: .medium,
            effect: "acids and retinoids degrade growth factor peptides, wasting the most expensive ingredient in your routine",
            advice: "use EGF on its own or with gentle hydrators only"
        ),

        IngredientInteraction(
            ingredientA: ["epidermal growth factor", "egf", "sh-oligopeptide-1"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "benzoyl peroxide oxidizes and degrades growth factors completely",
            advice: "never use EGF products with benzoyl peroxide"
        ),

        IngredientInteraction(
            ingredientA: ["epidermal growth factor", "egf", "sh-oligopeptide-1"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .medium,
            effect: "vitamin C's acidic pH can denature growth factor proteins",
            advice: "use vitamin C and EGF in separate routines"
        ),

        // MARK: - Ferment conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["galactomyces ferment filtrate", "saccharomyces ferment filtrate", "bifida ferment lysate", "lactobacillus ferment"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "benzoyl peroxide is an oxidizer that destroys the beneficial compounds in ferment filtrates",
            advice: "use ferment products in AM routine, benzoyl peroxide in PM"
        ),

        IngredientInteraction(
            ingredientA: ["galactomyces ferment filtrate", "saccharomyces ferment filtrate", "bifida ferment lysate"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .medium,
            effect: "strong AHAs can denature the proteins and enzymes in ferment filtrates",
            advice: "apply ferment essence first on clean skin, wait 5 minutes, then acid"
        ),

        // MARK: - Centella conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["centella asiatica", "madecassoside", "asiaticoside", "madecassic acid", "asiatic acid"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .medium,
            effect: "strong AHAs reduce centella's soothing and healing benefits by lowering skin pH too much",
            advice: "apply centella after acid has fully absorbed, or use in separate routines"
        ),

        // MARK: - Tranexamic acid conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["tranexamic acid"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .medium,
            effect: "both can cause dryness and sensitivity — together they increase irritation risk for sensitive skin",
            advice: "introduce slowly, alternate nights until skin adjusts"
        ),

        IngredientInteraction(
            ingredientA: ["tranexamic acid"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .medium,
            effect: "AHAs can reduce tranexamic acid's stability at very low pH",
            advice: "apply tranexamic acid first, wait 10 minutes, then AHA — or use in separate routines"
        ),

        // MARK: - Snail mucin conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["snail mucin", "snail secretion filtrate"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .medium,
            effect: "acids can break down the glycoproteins in snail mucin, reducing its hydrating benefits",
            advice: "apply acid first, wait 10-15 minutes, then apply snail mucin"
        ),

        // MARK: - Retinol + miscellaneous (MEDIUM)

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene"],
            ingredientB: ["chlorine", "chlorinated water"],
            severity: .medium,
            effect: "chlorine is a strong oxidizer that irritates retinoid-sensitized skin",
            advice: "apply a barrier cream before swimming, cleanse and moisturize immediately after"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin"],
            ingredientB: ["physical scrub", "walnut shell", "apricot kernel", "microbeads"],
            severity: .medium,
            effect: "physical exfoliation + chemical exfoliation (retinoid) together tears and damages the skin",
            advice: "never use scrubs on retinoid nights — if you must exfoliate physically, skip retinol that night"
        ),

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin"],
            ingredientB: ["clindamycin", "clindamycin phosphate"],
            severity: .medium,
            effect: "clindamycin can increase retinoid penetration, leading to more dryness than expected",
            advice: "apply clindamycin first, let absorb, then retinoid — and moisturize well"
        ),

        // MARK: - Vitamin C + miscellaneous (MEDIUM)

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            ingredientB: ["iron oxide"],
            severity: .medium,
            effect: "iron can catalyze vitamin C oxidation, turning the serum brown and making it ineffective",
            advice: "apply vitamin C first and let fully absorb before iron oxide sunscreen or makeup"
        ),

        IngredientInteraction(
            ingredientA: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            ingredientB: ["chlorine", "chlorinated water"],
            severity: .medium,
            effect: "chlorine oxidizes vitamin C on contact, wasting the product",
            advice: "apply vitamin C after swimming, not before"
        ),

        // MARK: - Kojic acid conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["kojic acid"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .medium,
            effect: "both are irritating at lower pH — layering increases sensitivity and redness",
            advice: "alternate days or use a product pre-formulated with both at tested concentrations"
        ),

        IngredientInteraction(
            ingredientA: ["kojic acid"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "benzoyl peroxide can oxidize and destabilize kojic acid",
            advice: "use kojic acid in AM, benzoyl peroxide in PM"
        ),

        // MARK: - Alpha arbutin conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["alpha arbutin", "arbutin"],
            ingredientB: ["benzoyl peroxide"],
            severity: .medium,
            effect: "benzoyl peroxide oxidizes arbutin, reducing its brightening effectiveness",
            advice: "use arbutin in AM, benzoyl peroxide in PM"
        ),

        IngredientInteraction(
            ingredientA: ["alpha arbutin", "arbutin"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .medium,
            effect: "retinol's exfoliation can reduce arbutin's time on skin, lowering its brightening effect",
            advice: "use arbutin in AM, retinol in PM"
        ),

        // MARK: - Benzoyl peroxide + miscellaneous (MEDIUM)

        IngredientInteraction(
            ingredientA: ["benzoyl peroxide"],
            ingredientB: ["avobenzone", "butyl methoxydibenzoylmethane"],
            severity: .medium,
            effect: "benzoyl peroxide destabilizes avobenzone, the most common UVA filter in chemical sunscreens",
            advice: "use mineral sunscreen (zinc oxide) instead of chemical sunscreen with benzoyl peroxide"
        ),

        IngredientInteraction(
            ingredientA: ["benzoyl peroxide"],
            ingredientB: ["dapsone"],
            severity: .medium,
            effect: "benzoyl peroxide + dapsone causes temporary orange-yellow skin discoloration",
            advice: "apply dapsone first and let fully absorb before benzoyl peroxide, or use at different times"
        ),

        // MARK: - Hyaluronic acid in dry climates (MEDIUM)

        IngredientInteraction(
            ingredientA: ["hyaluronic acid", "sodium hyaluronate"],
            ingredientB: ["alcohol denat", "sd alcohol", "denatured alcohol"],
            severity: .medium,
            effect: "alcohol strips moisture while HA tries to pull it in — in dry environments HA can pull water from deeper skin layers, making dryness worse",
            advice: "always seal hyaluronic acid with a moisturizer, and avoid alcohol-based products in dry climates"
        ),

        // MARK: - Zinc conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["zinc pyrithione"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .medium,
            effect: "acids reduce zinc pyrithione's antifungal effectiveness by changing its pH",
            advice: "use zinc pyrithione products separately from acid treatments"
        ),

        // MARK: - Calamine conflicts (MEDIUM)

        IngredientInteraction(
            ingredientA: ["calamine", "zinc oxide"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .medium,
            effect: "calamine/zinc oxide neutralizes acid pH, reducing exfoliation effectiveness",
            advice: "apply acid first, let absorb completely, then calamine if needed"
        ),

        // ╔══════════════════════════════════════════════════════╗
        // ║                  LOW SEVERITY                        ║
        // ║  Minor effectiveness reduction or order-dependent     ║
        // ╚══════════════════════════════════════════════════════╝

        // MARK: - Hyaluronic acid conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["hyaluronic acid", "sodium hyaluronate"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "acids lower pH which slightly reduces hyaluronic acid's hydrating ability",
            advice: "apply acid first, wait a few minutes, then apply hyaluronic acid"
        ),

        // MARK: - Niacinamide + acid conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["niacinamide", "nicotinamide"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHA's low pH can reduce niacinamide effectiveness and cause mild flushing",
            advice: "wait 10-15 minutes between them, or use in separate routines"
        ),

        IngredientInteraction(
            ingredientA: ["niacinamide", "nicotinamide"],
            ingredientB: ["salicylic acid"],
            severity: .low,
            effect: "salicylic acid's low pH slightly reduces niacinamide's effectiveness",
            advice: "apply salicylic acid first, wait 10 minutes, then niacinamide"
        ),

        // MARK: - Arbutin conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["alpha arbutin", "arbutin"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHA can destabilize arbutin at very low pH, reducing its brightening effect",
            advice: "apply arbutin after AHA has absorbed, or use in separate routines"
        ),

        // MARK: - Sunscreen conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["zinc oxide", "titanium dioxide"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .low,
            effect: "mineral sunscreen can slightly reduce vitamin C absorption",
            advice: "apply vitamin C first and let it fully absorb before sunscreen"
        ),

        IngredientInteraction(
            ingredientA: ["avobenzone", "butyl methoxydibenzoylmethane"],
            ingredientB: ["octinoxate", "ethylhexyl methoxycinnamate"],
            severity: .low,
            effect: "octinoxate can destabilize avobenzone over time, reducing UVA protection",
            advice: "look for sunscreens stabilized with octocrylene, or use mineral filters"
        ),

        IngredientInteraction(
            ingredientA: ["zinc oxide", "titanium dioxide"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "mineral sunscreen particles can buffer acid pH slightly, reducing exfoliation",
            advice: "use acid products in PM routine, mineral sunscreen only in AM"
        ),

        // MARK: - Occlusive conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["petroleum", "petrolatum", "mineral oil", "paraffinum liquidum", "microcrystalline wax"],
            ingredientB: ["retinol", "retinal", "tretinoin", "niacinamide", "hyaluronic acid", "sodium hyaluronate"],
            severity: .low,
            effect: "heavy occlusives applied before actives create a barrier that blocks absorption",
            advice: "always apply actives first, then seal with occlusive as the last step"
        ),

        // MARK: - Silicone conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["silicone", "dimethicone", "cyclomethicone", "cyclopentasiloxane", "dimethiconol", "cyclohexasiloxane", "trimethicone"],
            ingredientB: ["hyaluronic acid", "sodium hyaluronate", "niacinamide", "nicotinamide"],
            severity: .low,
            effect: "silicones form a film that can reduce penetration of water-soluble actives applied after",
            advice: "apply water-based serums before silicone-based primers or moisturizers"
        ),

        IngredientInteraction(
            ingredientA: ["silicone", "dimethicone", "cyclomethicone", "cyclopentasiloxane"],
            ingredientB: ["zinc oxide", "titanium dioxide"],
            severity: .low,
            effect: "heavy silicone layers under mineral sunscreen can cause pilling and uneven sun protection",
            advice: "let silicone primer set for 2-3 minutes before applying mineral sunscreen"
        ),

        // MARK: - Ceramide conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["ceramide np", "ceramide ap", "ceramide eop", "phytosphingosine", "ceramide ns", "ceramide as"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "acids can slightly disrupt the ceramide barrier layer if applied simultaneously",
            advice: "apply acid first, let absorb for 10 minutes, then ceramide moisturizer to rebuild barrier"
        ),

        // MARK: - Squalane conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["squalane", "squalene"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .low,
            effect: "squalane reduces vitamin C penetration when applied first",
            advice: "apply vitamin C serum first on clean skin, then layer squalane on top"
        ),

        // MARK: - Propolis conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["propolis", "propolis extract"],
            ingredientB: ["salicylic acid"],
            severity: .low,
            effect: "both have anti-inflammatory properties — combining is redundant and may cause mild dryness",
            advice: "choose one for your anti-acne step"
        ),

        IngredientInteraction(
            ingredientA: ["propolis", "propolis extract"],
            ingredientB: ["benzoyl peroxide"],
            severity: .low,
            effect: "benzoyl peroxide can oxidize propolis flavonoids, reducing their antioxidant benefit",
            advice: "use propolis in AM, benzoyl peroxide in PM"
        ),

        // MARK: - Panthenol conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["panthenol", "dexpanthenol", "provitamin b5", "d-panthenol"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHA's low pH slightly reduces panthenol's barrier-repair effectiveness",
            advice: "apply panthenol 10-15 minutes after acid to maximize both benefits"
        ),

        // MARK: - Allantoin conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["allantoin"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "allantoin's soothing effect is reduced at very low pH",
            advice: "apply acid first, then allantoin-rich moisturizer to soothe"
        ),

        // MARK: - Oatmeal conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["colloidal oatmeal", "avena sativa"],
            ingredientB: ["glycolic acid", "lactic acid", "retinol", "tretinoin"],
            severity: .low,
            effect: "oatmeal is meant to soothe — mixing with irritating actives sends mixed signals to your skin",
            advice: "use oatmeal products as recovery after active nights, not simultaneously"
        ),

        // MARK: - Honey conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["honey", "manuka honey"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "honey's natural sugars can interfere with AHA exfoliation at the skin surface",
            advice: "use honey masks on non-acid days for maximum benefit from both"
        ),

        // MARK: - Adenosine conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["adenosine"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "acids can reduce adenosine stability, diminishing its anti-wrinkle effect",
            advice: "apply adenosine after acid has absorbed, or use in PM routine"
        ),

        // MARK: - Peptide conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["peptides", "palmitoyl tripeptide-1", "palmitoyl tetrapeptide-7", "acetyl hexapeptide-8", "matrixyl", "argireline", "palmitoyl pentapeptide-4", "tripeptide-1", "hexapeptide-9", "myristoyl pentapeptide-17", "oligopeptide-1"],
            ingredientB: ["glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "acids can break peptide bonds, reducing effectiveness of expensive peptide serums",
            advice: "use peptides and acids in separate routines — acids AM or alternate nights, peptides PM"
        ),

        IngredientInteraction(
            ingredientA: ["peptides", "palmitoyl tripeptide-1", "palmitoyl tetrapeptide-7", "acetyl hexapeptide-8", "matrixyl", "argireline"],
            ingredientB: ["vitamin c", "ascorbic acid", "l-ascorbic acid"],
            severity: .low,
            effect: "vitamin C's low pH can destabilize peptides and reduce their anti-aging benefits",
            advice: "use vitamin C in AM, peptides in PM for best results from both"
        ),

        IngredientInteraction(
            ingredientA: ["peptides", "palmitoyl tripeptide-1", "matrixyl", "argireline", "acetyl hexapeptide-8"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .low,
            effect: "retinol's exfoliating action can reduce the time peptides spend on skin",
            advice: "apply peptide serum first, let absorb, then retinol — or alternate nights"
        ),

        // MARK: - Resveratrol conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["resveratrol"],
            ingredientB: ["benzoyl peroxide"],
            severity: .low,
            effect: "benzoyl peroxide oxidizes resveratrol, neutralizing its antioxidant benefits",
            advice: "use resveratrol in AM, benzoyl peroxide in PM"
        ),

        IngredientInteraction(
            ingredientA: ["resveratrol"],
            ingredientB: ["iron oxide"],
            severity: .low,
            effect: "iron can catalyze resveratrol oxidation, reducing its antioxidant effect",
            advice: "apply resveratrol serum before iron oxide-containing products"
        ),

        // MARK: - Glycerin conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["glycerin"],
            ingredientB: ["salicylic acid"],
            severity: .low,
            effect: "glycerin can slightly buffer salicylic acid's exfoliating action on oily skin",
            advice: "apply salicylic acid on clean skin first, then glycerin-rich moisturizer after"
        ),

        // MARK: - Sulfate conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["sodium lauryl sulfate", "sodium laureth sulfate", "sls", "sles", "ammonium lauryl sulfate"],
            ingredientB: ["retinol", "retinal", "tretinoin", "niacinamide", "vitamin c", "ascorbic acid"],
            severity: .low,
            effect: "harsh sulfates strip the skin barrier, making actives penetrate more aggressively and causing irritation",
            advice: "switch to a gentle, sulfate-free cleanser when using active ingredients"
        ),

        IngredientInteraction(
            ingredientA: ["sodium lauryl sulfate", "sodium laureth sulfate", "sls", "sles"],
            ingredientB: ["ceramide np", "ceramide ap", "ceramide eop"],
            severity: .low,
            effect: "sulfates strip ceramides from the skin, counteracting ceramide moisturizer benefits",
            advice: "use a sulfate-free cleanser to preserve your skin's natural ceramide barrier"
        ),

        // MARK: - Alcohol + hydration conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["alcohol denat", "sd alcohol", "denatured alcohol", "isopropyl alcohol"],
            ingredientB: ["hyaluronic acid", "sodium hyaluronate"],
            severity: .low,
            effect: "alcohol dehydrates the skin while hyaluronic acid tries to hydrate — they work against each other",
            advice: "avoid alcohol-based toners when your routine relies on hyaluronic acid for hydration"
        ),

        IngredientInteraction(
            ingredientA: ["alcohol denat", "sd alcohol", "denatured alcohol"],
            ingredientB: ["ceramide np", "ceramide ap", "ceramide eop", "phytosphingosine"],
            severity: .low,
            effect: "alcohol disrupts the lipid barrier that ceramides are trying to rebuild",
            advice: "avoid alcohol-heavy products when using ceramide-based barrier repair"
        ),

        // MARK: - Fragrance + active conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["fragrance", "parfum", "linalool", "limonene", "citronellol", "geraniol", "eugenol", "coumarin", "benzyl alcohol"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "lactic acid"],
            severity: .low,
            effect: "fragrance compounds are sensitizing — actives make skin more vulnerable to fragrance irritation",
            advice: "choose fragrance-free products when using actives to minimize irritation risk"
        ),

        // MARK: - Essential oil conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["essential oils", "lavender oil", "eucalyptus oil", "peppermint oil", "rosemary oil", "ylang ylang oil", "clove oil", "oregano oil", "thyme oil"],
            ingredientB: ["retinol", "retinal", "tretinoin", "glycolic acid", "lactic acid", "salicylic acid"],
            severity: .low,
            effect: "essential oils are natural irritants that compound with active ingredient sensitivity",
            advice: "avoid essential oil products on active nights to reduce irritation"
        ),

        // MARK: - Aloe vera conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["aloe vera", "aloe barbadensis"],
            ingredientB: ["hydrocortisone", "cortisone"],
            severity: .low,
            effect: "aloe vera can increase absorption of topical steroids, potentially amplifying side effects",
            advice: "use aloe vera and hydrocortisone at different times"
        ),

        // MARK: - Green tea conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["green tea extract", "camellia sinensis", "egcg", "epigallocatechin gallate"],
            ingredientB: ["iron oxide"],
            severity: .low,
            effect: "iron ions can oxidize green tea catechins, reducing their antioxidant effect",
            advice: "apply green tea serum before iron oxide sunscreen, let absorb first"
        ),

        IngredientInteraction(
            ingredientA: ["green tea extract", "camellia sinensis", "egcg"],
            ingredientB: ["benzoyl peroxide"],
            severity: .low,
            effect: "benzoyl peroxide oxidizes green tea antioxidants, reducing their protective benefits",
            advice: "use green tea products in AM, benzoyl peroxide in PM"
        ),

        // MARK: - Turmeric conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["turmeric", "curcumin", "curcuma longa"],
            ingredientB: ["benzoyl peroxide"],
            severity: .low,
            effect: "benzoyl peroxide can cause orange-yellow staining when mixed with turmeric",
            advice: "use turmeric masks separately from benzoyl peroxide treatments"
        ),

        IngredientInteraction(
            ingredientA: ["turmeric", "curcumin", "curcuma longa"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHAs can destabilize curcumin at low pH, reducing its anti-inflammatory benefits",
            advice: "use turmeric products and AHAs in separate routines"
        ),

        // MARK: - Licorice root conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["licorice root", "glycyrrhiza glabra", "glabridin"],
            ingredientB: ["benzoyl peroxide"],
            severity: .low,
            effect: "benzoyl peroxide can oxidize licorice's brightening compounds",
            advice: "use licorice products in AM, benzoyl peroxide in PM"
        ),

        // MARK: - Retinol + sunlight warning (LOW)

        IngredientInteraction(
            ingredientA: ["retinol", "retinal", "tretinoin", "adapalene", "tazarotene"],
            ingredientB: ["avobenzone", "octinoxate", "oxybenzone", "homosalate"],
            severity: .low,
            effect: "retinoids increase sun sensitivity — chemical sunscreens alone may not provide enough protection",
            advice: "use a high SPF broad-spectrum sunscreen (SPF 50+) daily when using retinoids"
        ),

        // MARK: - Rice extract conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["rice extract", "oryza sativa", "rice ferment filtrate", "sake"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHAs can reduce the effectiveness of rice-derived brightening compounds",
            advice: "use rice products in the morning, AHAs at night"
        ),

        // MARK: - Urea conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["urea"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "urea is a mild exfoliant — combining with AHAs can lead to over-exfoliation on sensitive skin",
            advice: "use urea moisturizer on non-acid days, or only on body skin where tolerance is higher"
        ),

        IngredientInteraction(
            ingredientA: ["urea"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .low,
            effect: "urea can increase retinoid penetration slightly, amplifying dryness",
            advice: "use urea in AM, retinol in PM — or on alternate days"
        ),

        // MARK: - Charcoal conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["activated charcoal", "charcoal"],
            ingredientB: ["niacinamide", "hyaluronic acid", "sodium hyaluronate", "vitamin c", "ascorbic acid"],
            severity: .low,
            effect: "activated charcoal can adsorb water-soluble actives, pulling them away from the skin",
            advice: "use charcoal masks before your serum routine, not after applying actives"
        ),

        // MARK: - Clay conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["kaolin", "bentonite", "french green clay", "montmorillonite"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .low,
            effect: "clay masks are drying — using on retinoid-treated skin amplifies dryness and tightness",
            advice: "use clay masks on non-retinoid nights, and follow with a rich moisturizer"
        ),

        IngredientInteraction(
            ingredientA: ["kaolin", "bentonite", "french green clay"],
            ingredientB: ["hyaluronic acid", "sodium hyaluronate"],
            severity: .low,
            effect: "clay pulls moisture from skin — counteracts hyaluronic acid's hydrating effect",
            advice: "apply hyaluronic acid serum after washing off clay mask to replenish hydration"
        ),

        // MARK: - Vitamin A derivatives doubling (LOW)

        IngredientInteraction(
            ingredientA: ["beta carotene", "carotenoids"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .low,
            effect: "beta carotene converts to vitamin A in the body — topical combination is redundant and mildly irritating",
            advice: "no need to use both — pick one vitamin A source"
        ),

        // MARK: - Glycolic acid + physical exfoliation (LOW)

        IngredientInteraction(
            ingredientA: ["glycolic acid", "lactic acid", "salicylic acid"],
            ingredientB: ["physical scrub", "walnut shell", "apricot kernel", "sugar scrub", "salt scrub"],
            severity: .low,
            effect: "chemical + physical exfoliation together is too aggressive for facial skin",
            advice: "choose one method per session — chemical OR physical, not both"
        ),

        // MARK: - Niacinamide + zinc (LOW)

        IngredientInteraction(
            ingredientA: ["niacinamide", "nicotinamide"],
            ingredientB: ["zinc oxide"],
            severity: .low,
            effect: "zinc oxide can slightly reduce niacinamide absorption when applied together",
            advice: "apply niacinamide first, let absorb, then zinc-based sunscreen"
        ),

        // MARK: - Caffeine conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["caffeine"],
            ingredientB: ["retinol", "retinal", "tretinoin"],
            severity: .low,
            effect: "caffeine can constrict blood vessels while retinol dilates them — mixed signals reduce both benefits slightly",
            advice: "use caffeine eye cream in AM, retinol in PM for best results from both"
        ),

        // MARK: - Azelaic acid + benzoyl peroxide (LOW)

        IngredientInteraction(
            ingredientA: ["azelaic acid"],
            ingredientB: ["benzoyl peroxide"],
            severity: .low,
            effect: "both are anti-acne treatments that can cause combined dryness on sensitive skin",
            advice: "use one in AM and one in PM, or alternate days if skin is sensitive"
        ),

        // MARK: - Mushroom extract conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["tremella fuciformis", "snow mushroom", "reishi", "ganoderma lucidum", "chaga"],
            ingredientB: ["glycolic acid", "lactic acid"],
            severity: .low,
            effect: "AHAs can degrade mushroom polysaccharides that provide hydration",
            advice: "apply mushroom extracts after acid has absorbed"
        ),

        // MARK: - Coenzyme Q10 conflicts (LOW)

        IngredientInteraction(
            ingredientA: ["coenzyme q10", "ubiquinone", "idebenone"],
            ingredientB: ["benzoyl peroxide"],
            severity: .low,
            effect: "benzoyl peroxide oxidizes CoQ10, neutralizing its antioxidant and anti-aging benefits",
            advice: "use CoQ10 in AM, benzoyl peroxide in PM"
        ),

        // MARK: - Salicylic acid + niacinamide pH (LOW)

        IngredientInteraction(
            ingredientA: ["salicylic acid"],
            ingredientB: ["zinc pyrithione"],
            severity: .low,
            effect: "salicylic acid's low pH can reduce zinc pyrithione's antimicrobial activity",
            advice: "use in separate routines for best results"
        ),
    ]
}
// swiftlint:enable file_length type_body_length
