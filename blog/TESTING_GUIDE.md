# 🧪 Blog Platform - Tam Test Kılavuzu

Bu kılavuz, blog platformunun hem backend (Cucumber) hem de frontend (Cypress) testlerinin nasıl çalıştırılacağını açıklar.

## 📋 İçindekiler

1. [Backend API Testleri (Cucumber)](#backend-api-testleri-cucumber)
2. [Frontend E2E Testleri (Cypress)](#frontend-e2e-testleri-cypress)
3. [Video Kayıtları](#video-kayıtları)
4. [Tam Test Akışı](#tam-test-akışı)

---

## 🔧 Backend API Testleri (Cucumber)

### Kurulum

```bash
cd backend
bundle install
```

### Test Senaryoları

✅ **Authentication:** Kullanıcı kayıt ve giriş\
✅ **Categories:** Kategori CRUD işlemleri\
✅ **Tags:** Tag CRUD işlemleri\
✅ **Posts:** Makale CRUD işlemleri\
✅ **Users:** Kullanıcı yönetimi

### Testleri Çalıştırma

**1. Backend Sunucusunu Başlat:**
```bash
cd backend
rails server
```

**2. Yeni Terminal'de Tüm Testleri Çalıştır:**
```bash
cd backend
cucumber
```

**3. Belirli Bir Feature'ı Test Et:**
```bash
cucumber features/authentication.feature
cucumber features/categories.feature
cucumber features/tags.feature
cucumber features/posts.feature
cucumber features/users.feature
```

### Örnek Çıktı

```
Feature: Kullanıcı Kimlik Doğrulama

  Senaryo: Yeni kullanıcı kaydı                    # features/authentication.feature:5
    Eğer ki "John Doe" adında yeni bir kullanıcı kaydolmak istiyor
    Ve email adresi "john.test@example.com"
    Ve şifresi "password123"
    O zaman kayıt başarılı olmalı
    Ve JWT token almalı
    Ve kullanıcı bilgileri dönmeli

  Senaryo: Mevcut kullanıcı girişi                 # features/authentication.feature:13
    Eğer ki sistemde "admin@blog.com" email'li bir kullanıcı var
    Ve doğru şifre "password123" ile giriş yapıyor
    O zaman giriş başarılı olmalı
    Ve JWT token almalı
    Ve kullanıcı rolü "admin" olmalı

5 scenarios (5 passed)
24 steps (24 passed)
0m2.347s
```

### Detaylı Dokümantasyon

Daha fazla bilgi için: [backend/TESTING.md](backend/TESTING.md)

---

## 🎭 Frontend E2E Testleri (Cypress)

### Kurulum

```bash
cd frontend
npm install
```

### Test Senaryoları

**1. Authentication (Kimlik Doğrulama):**
- Ana sayfa yükleme
- Giriş/Çıkış yapma
- Kayıt olma
- Hatalı giriş kontrolü

**2. Categories (Admin):**
- Kategori listeleme
- Kategori ekleme/düzenleme/silme

**3. Tags (Admin):**
- Tag listeleme
- Tag ekleme/düzenleme/silme

**4. Posts (Makaleler):**
- Makale listeleme
- Makale oluşturma (taslak/yayınlanmış)
- Makale düzenleme/silme
- Makale detay görüntüleme

**5. Users (Admin):**
- Kullanıcı listeleme
- Kullanıcı silme
- Yetki kontrolleri

### Testleri Çalıştırma

**1. Backend ve Frontend Başlatın:**
```bash
# Terminal 1 - Backend
cd backend
rails server

# Terminal 2 - Frontend
cd frontend
npm run dev
```

**2. Cypress Testlerini Çalıştırın:**

**İnteraktif Mod (UI ile):**
```bash
cd frontend
npm run cypress:open
```
- Cypress UI açılır
- Testleri tek tek veya hep birlikte çalıştırabilirsiniz
- Gerçek zamanlı test izleyebilirsiniz

**Headless Mod (Arka planda + Video Kayıt):**
```bash
cd frontend
npm run test:e2e
```

**Görünür Mod (Debugging için):**
```bash
npm run test:e2e:headed
```

### Video Kayıtları

Cypress otomatik olarak tüm testlerin videosunu kaydeder:

**Konum:** `frontend/cypress/videos/`

**Videolar:**
- `01-authentication.cy.js.mp4` - Giriş/Kayıt testleri
- `02-categories.cy.js.mp4` - Kategori yönetimi
- `03-tags.cy.js.mp4` - Tag yönetimi
- `04-posts.cy.js.mp4` - Makale yönetimi
- `05-users.cy.js.mp4` - Kullanıcı yönetimi

### Örnek Test Çıktısı

```
  (Run Starting)

  ┌────────────────────────────────────────────────────────────────────────────────────────────────┐
  │ Cypress:        15.6.0                                                                         │
  │ Browser:        Chrome 120 (headless)                                                          │
  │ Node Version:   v18.18.0                                                                       │
  │ Specs:          5 found (01-authentication.cy.js, 02-categories.cy.js, ...)                   │
  └────────────────────────────────────────────────────────────────────────────────────────────────┘

  Running:  01-authentication.cy.js                                                         (1 of 5)

  Kullanıcı Kimlik Doğrulama
    ✓ Ana sayfa yüklenir (1234ms)
    ✓ Giriş sayfasına gidebilir (567ms)
    ✓ Admin olarak başarılı giriş yapabilir (2345ms)
    ✓ Normal kullanıcı olarak başarılı giriş yapabilir (2123ms)
    ✓ Hatalı şifre ile giriş yapamaz (1456ms)
    ✓ Kayıt sayfasına gidebilir (678ms)
    ✓ Yeni kullanıcı kaydı yapabilir (2567ms)
    ✓ Çıkış yapabilir (1234ms)


  8 passing (12s)

  (Videos)
  - cypress/videos/01-authentication.cy.js.mp4              (1280x720, 12s)

  (Run Finished)

  ┌────────────────────────────────────────────────────────────────────────────────────────────────┐
  │ Tests:        45                                                                                │
  │ Passing:      45                                                                                │
  │ Failing:      0                                                                                 │
  │ Pending:      0                                                                                 │
  │ Skipped:      0                                                                                 │
  │ Screenshots:  0                                                                                 │
  │ Video:        true                                                                              │
  │ Duration:     2 minutes, 34 seconds                                                             │
  └────────────────────────────────────────────────────────────────────────────────────────────────┘
```

### Detaylı Dokümantasyon

Daha fazla bilgi için: [frontend/TESTING.md](frontend/TESTING.md)

---

## 🎬 Video Kayıtları

### Cypress Video Özellikleri

- **Format:** MP4
- **Çözünürlük:** 1280x720
- **Sıkıştırma:** 32 (orta kalite)
- **Otomatik Kayıt:** Her test için ayrı video

### Video İzleme

```bash
# Windows
start frontend/cypress/videos/01-authentication.cy.js.mp4

# macOS
open frontend/cypress/videos/01-authentication.cy.js.mp4

# Linux
xdg-open frontend/cypress/videos/01-authentication.cy.js.mp4
```

### Video Ayarları

`frontend/cypress.config.js` dosyasında:
```javascript
video: true,
videoCompression: 32,
videosFolder: 'cypress/videos',
```

---

## 🚀 Tam Test Akışı

### Adım 1: Ortamı Hazırla

```bash
# Veritabanını hazırla
cd backend
rails db:reset

# Backend'i başlat
rails server
```

### Adım 2: Backend API Testlerini Çalıştır

```bash
# Yeni terminal
cd backend
cucumber

# Tüm testler geçtikten sonra devam et
```

### Adım 3: Frontend'i Başlat

```bash
# Yeni terminal
cd frontend
npm run dev
```

### Adım 4: Frontend E2E Testlerini Çalıştır

```bash
# Yeni terminal
cd frontend

# İnteraktif mod
npm run cypress:open

# VEYA headless + video kayıt
npm run test:e2e
```

### Adım 5: Video Kayıtlarını İncele

```bash
cd frontend/cypress/videos
# Tüm .mp4 dosyalarını izleyin
```

---

## 📊 Test Kapsamı

### Backend API (Cucumber)
- **Feature Dosyaları:** 5
- **Senaryo Sayısı:** ~25
- **Test Kapsamı:** Authentication, CRUD işlemleri, Yetki kontrolleri

### Frontend E2E (Cypress)
- **Test Dosyaları:** 5
- **Test Sayısı:** ~45
- **Test Kapsamı:** UI işlemleri, Kullanıcı akışları, Form validasyonları

---

## 🐛 Sorun Giderme

### Backend Testleri Başarısız

```bash
# Sunucu çalışıyor mu?
curl http://localhost:3000/api/v1/categories

# Database temiz mi?
rails db:reset
```

### Frontend Testleri Başarısız

```bash
# Frontend çalışıyor mu?
curl http://localhost:5175

# Backend çalışıyor mu?
curl http://localhost:3000/api/v1/categories

# CORS hatası varsa backend'i yeniden başlat
```

### Video Kaydedilmiyor

`cypress.config.js` dosyasında `video: true` olduğundan emin olun.

---

## 📚 Ek Kaynaklar

- [Cucumber Documentation](https://cucumber.io/docs/cucumber/)
- [Cypress Documentation](https://docs.cypress.io/)
- [Backend Testing Docs](backend/TESTING.md)
- [Frontend Testing Docs](frontend/TESTING.md)

---

## ✅ Test Checklist

- [ ] Backend sunucusu çalışıyor
- [ ] Frontend sunucusu çalışıyor
- [ ] Database seed verileri yüklü
- [ ] Backend Cucumber testleri başarılı
- [ ] Frontend Cypress testleri başarılı
- [ ] Video kayıtları oluşturuldu
- [ ] Tüm videolar izlendi

---

**🎉 Test tamamlandı! Tüm senaryolar başarıyla çalışıyor.**

