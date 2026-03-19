# LalaRetro — Architecture

## Tech Stack
- **Platform:** iOS 17+ (SwiftUI)
- **Pattern:** MVVM (Model-View-ViewModel)
- **Storage:** UserDefaults (Phase 1), Backend TBD (Phase 2)
- **OCR:** Apple Vision framework
- **Barcode:** AVFoundation (Phase 1 — henüz eklenmedi)

## Proje Yapısı
```
LalaRetro/LalaRetro/
├── App/                  # Entry point, TabView
├── Models/               # Data modelleri (Product, UserReaction, SuspectResult)
├── Services/             # İş mantığı (LocalStorageService, OCRService)
├── ViewModels/           # Her ekran için ViewModel (@Observable)
├── Views/                # SwiftUI ekranları
│   ├── Home/             # Ürün arama
│   ├── Scanner/          # Barcode + OCR
│   ├── Reaction/         # Reaksiyon loglama
│   ├── Analyze/          # Suspect ingredient analizi
│   ├── Product/          # Ürün detay + ekleme
│   ├── Profile/          # Watchlist + geçmiş
│   └── Components/       # Ortak UI parçaları
├── Utils/                # Yardımcı araçlar (IngredientParser, CrossReferenceEngine)
└── Resources/            # Assets, colors
```

## Veri Akışı
```
Kullanıcı ürün ekler → LocalStorageService.saveProduct()
Kullanıcı reaksiyon loglar → LocalStorageService.saveReaction()
Analyze sekmesi → CrossReferenceEngine.findSuspects() → Ortak ingredient'ları bulur
Profile → Watchlist + geçmiş görüntüleme
```

## Tasarım Sistemi
- Font: Monospaced (retro aesthetic)
- Primary: Purple RGB(0.75, 0.55, 0.85)
- Danger: Pink RGB(0.75, 0.2, 0.45)
- Background: Light gradient
- Cards: White, rounded corners, subtle border
