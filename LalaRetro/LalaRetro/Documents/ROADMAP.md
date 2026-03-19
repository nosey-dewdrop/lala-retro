# LalaRetro — Roadmap

## Phase 1: MVP (Local-Only) ← ŞU AN BURADAYIZ
Hedef: Çalışan bir app, App Store'a çıkabilecek seviyede.

- [x] Proje yapısı (SwiftUI + MVVM)
- [x] LocalStorage ile veri kaydetme (UserDefaults)
- [x] Mock cosmetic data (6 ürün)
- [x] Firebase temizliği, async/await düzeltmeleri
- [x] Build başarılı
- [ ] View'lardaki async kalıntıları tam temizlik
- [ ] Barcode scanner (AVFoundation — gerçek cihaz)
- [ ] OCR flow uçtan uca (fotoğraf → ingredient parse → kaydet)
- [ ] Tüm tab'lar çalışır durumda (Home, Scan, React, Analyze, Profile)
- [ ] UI polish (tutarlı tema, empty state'ler, animasyonlar)
- [ ] App Store hazırlığı (icon, screenshots, description)

## Phase 2: Backend + Hesaplar
Hedef: Kullanıcılar hesap açsın, verileri bulutta kalsın.

- [ ] Backend seçimi (Supabase / Firebase / custom)
- [ ] Kullanıcı kaydı + giriş (Apple Sign In, email)
- [ ] Ürün veritabanı buluta taşınsın
- [ ] Kullanıcılar ürün eklesin → DB genişlesin (community-driven)
- [ ] Sync: local ↔ cloud (offline-first)

## Phase 3: Sosyal Özellikler
Hedef: Kullanıcılar birbirinden faydalansın.

- [ ] "Benzer cilt tipi" eşleştirme
- [ ] Ürün yorumları / reaksiyon paylaşımı
- [ ] "Bu üründen kaçın" önerileri (community data'ya göre)
- [ ] Ürün alternatifleri önerisi
- [ ] Leaderboard / güvenilir katkıda bulunanlar

## Phase 4: AI + Akıllı Özellikler
- [ ] Ingredient analizi (ne işe yarar, risk seviyesi)
- [ ] Kişiselleştirilmiş ürün önerileri
- [ ] "2 haftadır reaksiyon yok" push notification
- [ ] Ingredient timeline (ne zaman başladın, ne zaman düzeldi)
- [ ] Multi-language OCR
