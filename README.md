# LalaRetro hellooo

Cosmetic ingredient detective for iOS. Find out which ingredient is messing with your skin.

## What it does

- **Search** products by name or brand (45+ pre-loaded cosmetics)
- **Scan** barcodes with your camera to find products
- **OCR** — photograph ingredient lists and extract text automatically
- **Log reactions** — record which products caused skin reactions
- **Analyze** — cross-reference your reactions to find suspect ingredients
- **Watchlist** — track ingredients you're suspicious of

## Tech Stack

- SwiftUI + MVVM
- iOS 17+
- AVFoundation (barcode scanning)
- Apple Vision (OCR text recognition)
- UserDefaults (local storage)

## Brands Included

Sephora favorites, pharmacy classics, and K-beauty essentials:

CeraVe, The Ordinary, La Roche-Posay, Drunk Elephant, Rhode, Tatcha, Glow Recipe, Summer Fridays, Laneige, Fenty Skin, Rare Beauty, Paula's Choice, Supergoop!, Clinique, SK-II, Kiehl's, Neutrogena, Aestura, Beauty of Joseon, Yepoda, Caudalie, Darphin, Bioderma, Avene, Vichy, Embryolisse, Nuxe, Filorga, and more.

## How it works

1. Add products (search, scan barcode, or OCR ingredient list)
2. When your skin reacts, log which products you used
3. After 2+ reactions, the analyze tab cross-references ingredients
4. Common ingredients across reactions = suspects

## Build

Requires Xcode 15+ and [XcodeGen](https://github.com/yonaskolb/XcodeGen).

```bash
cd LalaRetro
xcodegen generate
open LalaRetro.xcodeproj
```

## License

MIT
