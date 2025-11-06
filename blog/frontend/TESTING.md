# Frontend E2E Test Dokümantasyonu

Bu dokümantasyon, React frontend'inin Cypress ile nasıl test edileceğini açıklar.

## Test Kurulumu

Cypress zaten yüklü. Test için gerekli tüm bağımlılıklar `package.json`'da mevcut.

## Test Senaryoları

### 1. Authentication (Kimlik Doğrulama)
- ✅ Ana sayfa yükleme
- ✅ Giriş sayfasına gitme
- ✅ Admin olarak başarılı giriş
- ✅ Normal kullanıcı olarak başarılı giriş
- ✅ Hatalı şifre ile giriş denemesi
- ✅ Kayıt sayfasına gitme
- ✅ Yeni kullanıcı kaydı
- ✅ Çıkış yapma

### 2. Categories (Kategoriler)
- ✅ Kategoriler sayfasına gitme
- ✅ Mevcut kategorileri görüntüleme
- ✅ Yeni kategori ekleme
- ✅ Kategori güncelleme
- ✅ Kategori silme

### 3. Tags
- ✅ Tags sayfasına gitme
- ✅ Mevcut tag'leri görüntüleme
- ✅ Yeni tag ekleme
- ✅ Tag güncelleme
- ✅ Tag silme

### 4. Posts (Makaleler)
- ✅ Posts sayfasına gitme
- ✅ Mevcut makaleleri görüntüleme
- ✅ Yeni makale ekleme
- ✅ Taslak makale oluşturma
- ✅ Makale güncelleme
- ✅ Makale silme
- ✅ Ana sayfada yayınlanmış makaleler görüntüleme
- ✅ Makale detay sayfası

### 5. Users (Kullanıcılar)
- ✅ Users sayfasına gitme (Admin)
- ✅ Tüm kullanıcıları görüntüleme
- ✅ Kullanıcı rollerini görme
- ✅ Kullanıcı silme (Admin)
- ✅ Normal kullanıcı kısıtlamaları

## Testleri Çalıştırma

### Ön Koşullar

1. **Backend çalışıyor olmalı:**
```bash
cd backend
rails server
# http://localhost:3000'de çalışmalı
```

2. **Frontend çalışıyor olmalı:**
```bash
cd frontend
npm run dev
# http://localhost:5175'te çalışmalı
```

3. **Veritabanı hazır olmalı:**
```bash
cd backend
rails db:seed
# Seed verileri yüklenmiş olmalı
```

### Test Komutları

**1. Cypress Test Runner'ı Aç (İnteraktif):**
```bash
cd frontend
npm run cypress:open
```
Bu komut Cypress UI'ını açar ve testleri manuel olarak seçip çalıştırabilirsiniz.

**2. Tüm Testleri Headless Modda Çalıştır:**
```bash
npm run cypress:run
```
Bu komut tüm testleri arka planda çalıştırır ve video kaydeder.

**3. Tüm Testleri Chrome'da Çalıştır:**
```bash
npm run test:e2e
```

**4. Testleri Görünür Pencerede Çalıştır:**
```bash
npm run test:e2e:headed
```
Bu komut testleri açık tarayıcıda gösterir (debugging için yararlı).

**5. Belirli Bir Test Dosyasını Çalıştır:**
```bash
npx cypress run --spec "cypress/e2e/01-authentication.cy.js"
npx cypress run --spec "cypress/e2e/02-categories.cy.js"
npx cypress run --spec "cypress/e2e/03-tags.cy.js"
npx cypress run --spec "cypress/e2e/04-posts.cy.js"
npx cypress run --spec "cypress/e2e/05-users.cy.js"
```

## Video Kayıtları

Cypress otomatik olarak test videolarını kaydeder:
- **Konum:** `frontend/cypress/videos/`
- **Format:** `.mp4`
- **İçerik:** Her test dosyası için ayrı video

Test sonrası videolar şurada bulunur:
```
frontend/
  cypress/
    videos/
      01-authentication.cy.js.mp4
      02-categories.cy.js.mp4
      03-tags.cy.js.mp4
      04-posts.cy.js.mp4
      05-users.cy.js.mp4
```

## Ekran Görüntüleri

Test başarısız olduğunda Cypress otomatik olarak ekran görüntüsü alır:
- **Konum:** `frontend/cypress/screenshots/`
- **Format:** `.png`

## Test Raporları

Cypress terminalde test sonuçlarını gösterir:
- ✅ Yeşil: Başarılı
- ❌ Kırmızı: Başarısız
- ⏭️ Atlanan testler

```
┌────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Tests:        45                                                                                │
│ Passing:      42                                                                                │
│ Failing:      0                                                                                 │
│ Pending:      3                                                                                 │
│ Skipped:      0                                                                                 │
│ Screenshots:  0                                                                                 │
│ Video:        true                                                                              │
│ Duration:     2 minutes, 34 seconds                                                             │
└────────────────────────────────────────────────────────────────────────────────────────────────┘
```

## Custom Commands

Test dosyalarında kullanabileceğiniz özel komutlar:

```javascript
// Admin olarak giriş yap
cy.loginAsAdmin();

// Normal kullanıcı olarak giriş yap
cy.loginAsUser();

// Özel email/şifre ile giriş yap
cy.login('user@example.com', 'password');

// Çıkış yap
cy.logout();
```

## Sorun Giderme

### Backend bağlantı hatası
```bash
# Backend'in çalıştığından emin olun
curl http://localhost:3000/api/v1/categories
```

### Frontend bağlantı hatası
```bash
# Frontend'in çalıştığından emin olun
# Tarayıcıda http://localhost:5175 açılıyor mu?
```

### Video kaydedilmiyor
Video kayıt ayarları `cypress.config.js` dosyasında:
```javascript
video: true,
videoCompression: 32,
```

### Test veritabanı temiz değil
```bash
cd backend
rails db:reset
```

## Best Practices

1. **Her test bağımsız olmalı** - Bir test diğerine bağlı olmamalı
2. **Test verileri temiz olmalı** - Her testten sonra cleanup yapılmalı
3. **Explicit waits kullanın** - `cy.wait(1000)` yerine `cy.contains('text')` kullanın
4. **Video kayıtlarını saklayın** - Hata debugging için çok yararlı

## CI/CD Entegrasyonu

GitHub Actions veya benzeri CI/CD sistemlerinde:

```yaml
- name: Run Cypress Tests
  run: |
    npm run cypress:run
  env:
    CYPRESS_baseUrl: http://localhost:5175
```

## Notlar

- Frontend `http://localhost:5175` adresinde çalışmalı
- Backend API `http://localhost:3000/api/v1` adresinde çalışmalı
- Seed verileri yüklenmiş olmalı
- Video kayıtları otomatik olarak `cypress/videos/` klasörüne kaydedilir
- Test sırasında tarayıcı otomatik olarak açılır/kapanır

