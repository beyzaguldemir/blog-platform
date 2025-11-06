# Blog Platform

Modern ve profesyonel bir blog platformu. Ruby on Rails backend ve React frontend ile geliştirilmiştir.

## 📋 Proje Hakkında

Bu proje, tam özellikli bir blog yönetim sistemidir. Kullanıcılar makale oluşturabilir, adminler ise tüm içeriği yönetebilir.

### Ana Özellikler

**Backend (Rails API):**
- JWT tabanlı kimlik doğrulama
- Kullanıcı, kategori, tag ve makale yönetimi
- Admin/User rol sistemi
- MySQL veritabanı

**Frontend (React):**
- Modern ve responsive tasarım (Tailwind CSS)
- Kullanıcı girişi/kayıt
- Admin paneli
- Protected routes

## 🚀 Hızlı Başlangıç

### Gereksinimler
- Ruby 3.4+, Rails 8.1+
- MySQL 5.7+
- Node.js 18+, npm

### Kurulum

**1. Backend:**
```bash
cd backend
bundle install
rails db:create db:migrate db:seed
rails server  # http://localhost:3000
```

**2. Frontend:**
```bash
cd frontend
npm install
npm run dev  # http://localhost:5173
```

### Demo Hesaplar

**Admin:** `admin@blog.com` / `password123`  
**Kullanıcı:** `john@blog.com` / `password123`

## 🧪 Test Sistemi

Bu proje, hem backend hem de frontend için kapsamlı test altyapısına sahiptir.

### 📊 Test Genel Bakış

- **Backend Testleri:** Cucumber (BDD) - 5 feature, ~25 senaryo
- **Frontend Testleri:** Cypress (E2E) - 5 dosya, ~45 test
- **Test Dili:** Türkçe (Türkçe BDD senaryoları)
- **Video Kayıt:** Otomatik (Cypress)

---

## 🔧 Backend Testleri (Cucumber)

### Test Framework
- **Cucumber-rails:** BDD (Behavior-Driven Development) test framework
- **HTTParty:** API istekleri için
- **Database Cleaner:** Test veritabanı temizliği
- **Factory Bot & Faker:** Test verisi oluşturma

### Test Senaryoları

#### 1. Authentication (Kimlik Doğrulama)
- ✅ Yeni kullanıcı kaydı
- ✅ Mevcut kullanıcı girişi
- ✅ Hatalı şifre ile giriş kontrolü
- ✅ JWT token doğrulama

#### 2. Categories (Kategoriler)
- ✅ Tüm kategorileri listeleme
- ✅ Yeni kategori oluşturma (Admin)
- ✅ Kategori güncelleme (Admin)
- ✅ Kategori silme (Admin)
- ✅ Yetkisiz kullanıcı kontrolü

#### 3. Tags
- ✅ Tüm tag'leri listeleme
- ✅ Yeni tag oluşturma (Admin)
- ✅ Tag güncelleme (Admin)
- ✅ Tag silme (Admin)

#### 4. Posts (Makaleler)
- ✅ Yayınlanmış makaleleri listeleme
- ✅ Makale detayını görüntüleme
- ✅ Yeni makale oluşturma
- ✅ Makaleye tag ekleme
- ✅ Kendi makalesini güncelleme
- ✅ Başkasının makalesini güncelleme (yetkisiz - 403)
- ✅ Admin tüm makaleleri yönetebilir
- ✅ Makale yayınlama/taslak durumu

#### 5. Users (Kullanıcılar)
- ✅ Tüm kullanıcıları listeleme (Admin)
- ✅ Kullanıcı silme (Admin)
- ✅ Normal kullanıcı kısıtlamaları (403)
- ✅ Kullanıcı kendi bilgilerini güncelleyebilir
- ✅ Başkasının bilgilerini güncelleyemez

### Testleri Çalıştırma

**1. Backend sunucusunu başlatın:**
```bash
cd backend
rails server
```

**2. Yeni terminalde testleri çalıştırın:**
```bash
cd backend

# Tüm testleri çalıştır
cucumber

# Belirli bir feature'ı test et
cucumber features/authentication.feature
cucumber features/posts.feature

# Belirli bir senaryoyu test et
cucumber features/authentication.feature:5
```

### Test Örnek Çıktısı

```
Feature: Kullanıcı Kimlik Doğrulama

  Senaryo: Yeni kullanıcı kaydı
    Eğer ki "John Doe" adında yeni bir kullanıcı kaydolmak istiyor
    Ve email adresi "john.test@example.com"
    Ve şifresi "password123"
    O zaman kayıt başarılı olmalı
    Ve JWT token almalı
    Ve kullanıcı bilgileri dönmeli

5 scenarios (5 passed)
24 steps (24 passed)
0m2.347s
```

### Test Verileri

Testler çalışmadan önce veritabanı temizlenir ve seed verileri yüklenir:
- Admin: `admin@blog.com` / `password123`
- Kullanıcılar: `john@blog.com`, `jane@blog.com` / `password123`
- 4 kategori, 8 tag, 6 makale (5 yayınlanmış, 1 taslak)

---

## 🎭 Frontend Testleri (Cypress)

### Test Framework
- **Cypress 15.6.0:** End-to-End test framework
- **Otomatik Video Kayıt:** Her test için MP4 video
- **Ekran Görüntüleri:** Başarısız testler için otomatik screenshot

### Test Senaryoları

#### 1. Authentication (Kimlik Doğrulama) - 8 test
- ✅ Ana sayfa yükleme
- ✅ Giriş sayfasına gitme
- ✅ Admin olarak başarılı giriş
- ✅ Normal kullanıcı olarak başarılı giriş
- ✅ Hatalı şifre ile giriş kontrolü
- ✅ Kayıt sayfasına gitme
- ✅ Yeni kullanıcı kaydı
- ✅ Çıkış yapma

#### 2. Categories (Kategoriler) - ~8 test
- ✅ Kategoriler sayfasına gitme
- ✅ Mevcut kategorileri görüntüleme
- ✅ Yeni kategori ekleme
- ✅ Kategori güncelleme
- ✅ Kategori silme

#### 3. Tags - ~7 test
- ✅ Tags sayfasına gitme
- ✅ Mevcut tag'leri görüntüleme
- ✅ Yeni tag ekleme
- ✅ Tag güncelleme
- ✅ Tag silme

#### 4. Posts (Makaleler) - ~15 test
- ✅ Posts sayfasına gitme
- ✅ Mevcut makaleleri görüntüleme
- ✅ Yeni makale ekleme
- ✅ Taslak makale oluşturma
- ✅ Makale güncelleme
- ✅ Makale silme
- ✅ Ana sayfada yayınlanmış makaleler
- ✅ Makale detay sayfası

#### 5. Users (Kullanıcılar) - ~7 test
- ✅ Users sayfasına gitme (Admin)
- ✅ Tüm kullanıcıları görüntüleme
- ✅ Kullanıcı rollerini görme
- ✅ Kullanıcı silme (Admin)
- ✅ Normal kullanıcı kısıtlamaları

### Testleri Çalıştırma

**Ön Koşullar:**
```bash
# Terminal 1 - Backend
cd backend
rails server

# Terminal 2 - Frontend
cd frontend
npm run dev
```

**Test Komutları:**

```bash
cd frontend

# İnteraktif mod (Cypress UI)
npm run cypress:open

# Headless mod (arka planda + video)
npm run test:e2e

# Görünür mod (debugging için)
npm run test:e2e:headed

# Belirli bir test dosyası
npx cypress run --spec "cypress/e2e/01-authentication.cy.js"
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

**Video Özellikleri:**
- Format: MP4
- Çözünürlük: 1280x720
- Sıkıştırma: 32 (orta kalite)
- Otomatik kayıt: Her test için ayrı video

### Custom Commands

Test dosyalarında kullanılan özel komutlar:

```javascript
// Admin olarak giriş yap
cy.loginAsAdmin();

// Normal kullanıcı olarak giriş yap
cy.loginAsUser();

// Özel email/şifre ile giriş
cy.login('user@example.com', 'password');

// Çıkış yap
cy.logout();
```

### Test Örnek Çıktısı

```
┌────────────────────────────────────────────────────────────────────────┐
│ Tests:        45                                                        │
│ Passing:      45                                                        │
│ Failing:      0                                                         │
│ Duration:     2 minutes, 34 seconds                                    │
│ Video:        true                                                      │
└────────────────────────────────────────────────────────────────────────┘

(Videos)
- cypress/videos/01-authentication.cy.js.mp4 (1280x720, 12s)
- cypress/videos/02-categories.cy.js.mp4 (1280x720, 8s)
...
```

---

## 📊 Test İstatistikleri

### Backend (Cucumber)
- **Feature Dosyaları:** 5
- **Toplam Senaryo:** ~25
- **Test Kapsamı:** Authentication, CRUD işlemleri, Yetki kontrolleri
- **Test Dili:** Türkçe BDD

### Frontend (Cypress)
- **Test Dosyaları:** 5
- **Toplam Test:** ~45
- **Test Kapsamı:** UI işlemleri, Kullanıcı akışları, Form validasyonları
- **Video Kayıt:** Otomatik (5 video)

---

## 🔌 API Endpoints

### Authentication
- `POST /api/v1/auth/login` - Giriş
- `POST /api/v1/auth/register` - Kayıt
- `GET /api/v1/users/me` - Mevcut kullanıcı

### Resources
- `GET/POST/PUT/DELETE /api/v1/users` - Kullanıcılar (Admin)
- `GET/POST/PUT/DELETE /api/v1/categories` - Kategoriler
- `GET/POST/PUT/DELETE /api/v1/tags` - Tag'ler
- `GET/POST/PUT/DELETE /api/v1/posts` - Makaleler

---

## 🛠️ Teknolojiler

**Backend:** Ruby on Rails 8.1, MySQL, JWT, BCrypt  
**Frontend:** React 18, Vite, Tailwind CSS, Axios  
**Test:** Cucumber (Backend), Cypress (Frontend)

---

## 📚 Detaylı Dokümantasyon

- [TESTING_GUIDE.md](TESTING_GUIDE.md) - Tam test kılavuzu
- [TEST_QUICKSTART.md](TEST_QUICKSTART.md) - Hızlı test başlangıcı
- [backend/TESTING.md](backend/TESTING.md) - Backend test detayları
- [frontend/TESTING.md](frontend/TESTING.md) - Frontend test detayları

---

## 🐛 Sorun Giderme

**Backend testleri başarısız:**
```bash
# Sunucu çalışıyor mu?
curl http://localhost:3000/api/v1/categories

# Database temizle
rails db:reset
```

**Frontend testleri başarısız:**
```bash
# Backend ve frontend çalışıyor mu?
# Port kontrolü: Backend 3000, Frontend 5173
```

---

**🎉 Proje tam test kapsamına sahiptir ve tüm senaryolar başarıyla çalışmaktadır!**
