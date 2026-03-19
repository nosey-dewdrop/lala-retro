# LalaRetro — Ideas & Notes

Aklımıza gelen her şey buraya. Kaybetmiyoruz.

---

## Büyük Vizyon
- Kullanıcılar hesap açacak
- Her kullanıcı ürün ekleyecek → DB community-driven büyüyecek
- Sosyal platform: "skincare detective" topluluğu
- Para kazanma: premium özellikler, AI analiz, reklamsız deneyim

## Teknik Kararlar
- **Neden şu an LocalStorage?** → MVP hızlı çıksın, backend'e gerek kalmadan çalışsın. Phase 2'de backend eklenir.
- **Neden Firebase'i kaldırdık?** → Konfigüre edilmemişti, çalışmıyordu. Temiz başlangıç.
- **Backend adayları:** Supabase (PostgreSQL, auth dahil), Firebase (kolay ama vendor lock), custom API (Node/Go + PostgreSQL)

## Feature Fikirleri
- **Ürün karşılaştırma:** İki ürünü yan yana koy, ortak ingredient'ları göster
- **Ingredient sözlüğü:** Her ingredient'a tıkla → ne olduğunu öğren
- **Barcode ile hızlı ekleme:** Tara → Open Beauty Facts API'den çek → kaydet
- **Fotoğraf galerisi:** Ürün fotoğrafları, reaksiyon fotoğrafları (cilt durumu)
- **İlaç/supplement desteği:** Sadece kozmetik değil, ilaçlar da
- **Export:** Verini PDF olarak doktora göster
- **Widget:** "Bugün dikkat et: X ingredient" iOS widget

## Monetization
- Freemium: Temel özellikler ücretsiz, AI analiz + detaylı raporlar premium
- Abonelik modeli (aylık/yıllık)
- Marka ortaklıkları (sponsorlu ürün önerileri — şeffaf şekilde)

## Sorular / Araştırılacak
- Open Beauty Facts API ne kadar kapsamlı? Türkiye ürünleri var mı?
- Apple Sign In zorunlu mu App Store için? (Evet, eğer başka sign-in varsa)
- KVKK / GDPR: Cilt/sağlık verisi hassas veri mi?
