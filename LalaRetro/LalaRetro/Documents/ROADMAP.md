# LalaRetro — Roadmap

## Phase 1: MVP (Local-Only) ← ŞU AN BURADAYIZ
Hedef: Çalışan bir app, App Store'a çıkabilecek seviyede.

- [x] Proje yapısı (SwiftUI + MVVM)
- [x] LocalStorage ile veri kaydetme (UserDefaults)
- [x] Mock cosmetic data (45+ ürün — Sephora, eczane, K-beauty)
- [x] Firebase temizliği, async/await düzeltmeleri
- [x] Build başarılı
- [x] View'lardaki async kalıntıları tam temizlik
- [x] Barcode scanner (AVFoundation — gerçek cihaz)
- [x] OCR flow uçtan uca (fotoğraf → ingredient parse → kaydet)
- [ ] Simulatörde full flow test
- [ ] UI polish (tutarlı tema, empty state'ler, animasyonlar)
- [ ] App Store hazırlığı (icon, screenshots, description)
- [ ] README.md

## Phase 2: Backend + Hesaplar
Hedef: Kullanıcılar hesap açsın, verileri bulutta kalsın.

- [x] iCloud sync (NSUbiquitousKeyValueStore, offline-first, automatic merge)
- [x] UserDefaults -> iCloud migration (one-time, transparent)
- [ ] Backend seçimi (Supabase / Firebase / custom)
- [ ] Kullanıcı kaydı + giriş (Apple Sign In, email)
- [ ] Ürün veritabanı buluta taşınsın
- [ ] Kullanıcılar ürün eklesin → DB genişlesin (community-driven)

## Phase 3: Sosyal Özellikler
Hedef: Kullanıcılar birbirinden faydalansın.

- [ ] "Benzer cilt tipi" eşleştirme
- [ ] Ürün yorumları / reaksiyon paylaşımı
- [ ] "Bu üründen kaçın" önerileri (community data'ya göre)
- [ ] Ürün alternatifleri önerisi
- [ ] Leaderboard / güvenilir katkıda bulunanlar

## Phase 4: AI + Akıllı Özellikler
- [x] Ingredient interaction checker (local database, 125 known combos, 3 severity levels)
- [x] Routine check (analyze tab, select products, see all interactions between them)
- [ ] Ingredient analizi (ne işe yarar, risk seviyesi)
- [ ] Kişiselleştirilmiş ürün önerileri
- [ ] "2 haftadır reaksiyon yok" push notification
- [ ] Ingredient timeline (ne zaman başladın, ne zaman düzeldi)
- [ ] Multi-language OCR
