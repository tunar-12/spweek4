# Mini Katalog Uygulaması

Flutter ile geliştirilmiş, ürünlerin listelendiği, ürün detaylarının görüntülendiği
ve basit bir sepet (state) yönetimi içeren temel seviye bir mobil katalog uygulaması.
Bu proje, Flutter günlük eğitim haftasının proje çıktısıdır.

## Proje Adı

**Mini Katalog Uygulaması** (`mini_katalog`)

## Kısa Açıklama

Uygulama üç ana ekrandan oluşur:

- **Discover (Ana Sayfa):** Promosyon banner'ı, arama kutusu ve `GridView` ile kart
  tabanlı ürün listesi.
- **Ürün Detayı:** Ürün görseli, açıklaması ve teknik özellikleri (SIZE / AUDIO / COLORS).
  Seçilen ürün, ekranlar arasına **Route Arguments** ile taşınır.
- **Sepet (Cart):** Ürün ekleme, adet artırma/azaltma, toplam tutar ve checkout
  simülasyonu. Sepet boşken "Your cart is empty" durumu gösterilir.

Ürün verileri gerçek bir API yerine `assets/products.json` dosyasından (JSON simülasyonu)
okunur; böylece `fromJson` mantığı ve asset yönetimi gösterilir. Görseller
`assets/images/` klasöründen `Image.asset` ile yüklenir. Hiçbir ekstra paket
kullanılmamıştır — yalnızca `material.dart`.

## Kullanılan Flutter Sürümü

- **Flutter:** 3.44.2 (stable kanal)
- **Dart SDK:** 3.0.0 – 4.0.0 (`pubspec.yaml` içinde tanımlı)

Kurulu sürümünüzü kontrol etmek için:

```bash
flutter --version
```

## Çalıştırma Adımları

1. Projeyi klonlayın:

   ```bash
   git clone <repository-url>
   cd mini_katalog
   ```

2. Bağımlılıkları yükleyin:

   ```bash
   flutter pub get
   ```

3. Bir emülatör veya fiziksel cihazın bağlı olduğundan emin olun:

   ```bash
   flutter devices
   ```

4. Uygulamayı çalıştırın:

   ```bash
   flutter run
   ```

   Belirli bir cihazda çalıştırmak için (örnek: Chrome):

   ```bash
   flutter run -d chrome
   ```

5. (Opsiyonel) Testleri çalıştırın:

   ```bash
   flutter test
   ```

## Proje Klasör Yapısı

```
mini_katalog/
├── lib/
│   ├── main.dart                   # Uygulama girişi, tema ve Named Routes
│   ├── models/
│   │   ├── product.dart            # Product modeli + fromJson/toJson
│   │   └── banner_info.dart        # Banner modeli
│   ├── data/
│   │   └── product_repository.dart # JSON'dan veri okuma (simülasyon)
│   ├── state/
│   │   └── cart_model.dart         # CartModel (ChangeNotifier) + CartScope
│   ├── screens/
│   │   ├── home_screen.dart        # Discover / ürün listesi
│   │   ├── product_detail_screen.dart
│   │   └── cart_screen.dart
│   ├── widgets/
│   │   ├── product_card.dart       # GridView kartı
│   │   ├── product_image.dart      # Image.asset + ikon yedeği
│   │   └── promo_banner.dart
│   └── theme/
│       └── app_theme.dart          # Basit UI teması
├── assets/
│   ├── products.json               # Ürün verisi (JSON simülasyonu)
│   └── images/                     # Ürün ve banner görselleri
├── test/
│   └── widget_test.dart            # Model ve sepet birim testleri
├── pubspec.yaml
└── README.md
```

## Öğrenme Hedefleri Eşlemesi

| Hedef | Nerede |
|------|--------|
| Widget yapısı, Stateless/Stateful | Tüm `lib/` |
| Sayfa geçişleri (Navigator) | `Navigator.pushNamed` (home → detail → cart) |
| Named Routes | `main.dart` → `routes` |
| Route Arguments | `home_screen.dart` (gönderme) → `product_detail_screen.dart` (okuma) |
| Model + fromJson/toJson | `models/product.dart` |
| JSON simülasyonu & asset yönetimi | `product_repository.dart`, `assets/products.json` |
| Image.asset ile görsel | `widgets/product_image.dart`, `widgets/promo_banner.dart` |
| ListView / GridView | `home_screen.dart` (GridView), `cart_screen.dart` (ListView) |
| Arama & filtreleme | `home_screen.dart` |
| Basit state güncelleme | `state/cart_model.dart` |
| Basit UI teması | `theme/app_theme.dart` |
