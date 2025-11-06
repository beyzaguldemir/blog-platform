# Backend API Test Dokümantasyonu

Bu dokümantasyon, Ruby on Rails API'sinin Cucumber ile nasıl test edileceğini açıklar.

## Test Kurulumu

Test gem'leri zaten yüklü:
- **cucumber-rails**: BDD test framework
- **rspec-rails**: Test assertion'ları için
- **database_cleaner**: Test veritabanını temizlemek için
- **httparty**: HTTP istekleri için
- **factory_bot_rails**: Test verileri için
- **faker**: Rastgele veri üretmek için

## Test Senaryoları

### 1. Authentication (Kimlik Doğrulama)
- ✅ Yeni kullanıcı kaydı
- ✅ Mevcut kullanıcı girişi
- ✅ Hatalı şifre ile giriş

### 2. Categories (Kategoriler)
- ✅ Tüm kategorileri listeleme
- ✅ Yeni kategori oluşturma (Admin)
- ✅ Kategori güncelleme (Admin)
- ✅ Kategori silme (Admin)
- ✅ Yetkisiz kullanıcı kategori oluşturamaz

### 3. Tags
- ✅ Tüm tag'leri listeleme
- ✅ Yeni tag oluşturma (Admin)
- ✅ Tag güncelleme (Admin)
- ✅ Tag silme (Admin)

### 4. Posts (Makaleler)
- ✅ Yayınlanmış makaleleri listeleme
- ✅ Makale detayını görüntüleme
- ✅ Yeni makale oluşturma
- ✅ Makaleye tag ekleme
- ✅ Kendi makalesini güncelleme
- ✅ Başkasının makalesini güncelleme (yetkisiz)
- ✅ Admin tüm makaleleri yönetebilir
- ✅ Makale yayınlama/taslak

### 5. Users (Kullanıcılar)
- ✅ Tüm kullanıcıları listeleme (Admin)
- ✅ Kullanıcı silme (Admin)
- ✅ Normal kullanıcı diğer kullanıcıları görüntüleyemez
- ✅ Kullanıcı kendi bilgilerini güncelleyebilir
- ✅ Kullanıcı başkasının bilgilerini güncelleyemez

## Testleri Çalıştırma

### Backend Sunucusunu Başlatın
```bash
cd backend
rails server
```

### Yeni Terminal'de Testleri Çalıştırın

**Tüm testleri çalıştır:**
```bash
cd backend
cucumber
```

**Belirli bir feature'ı test et:**
```bash
cucumber features/authentication.feature
cucumber features/categories.feature
cucumber features/tags.feature
cucumber features/posts.feature
cucumber features/users.feature
```

**Belirli bir senaryoyu test et:**
```bash
cucumber features/authentication.feature:6  # 6. satırdaki senaryo
```

**Türkçe çıktı ile test:**
```bash
cucumber --format pretty
```

## Test Raporları

Cucumber otomatik olarak terminalde test sonuçlarını gösterir:
- ✅ Yeşil: Başarılı
- ❌ Kırmızı: Başarısız
- ⚠️ Sarı: Pending/Tanımlanmamış

## Test Verileri

Testler çalışmadan önce veritabanı temizlenir ve seed verileri yüklenir:
- Admin kullanıcı: admin@blog.com / password123
- Normal kullanıcılar: john@blog.com / password123, jane@blog.com / password123
- 4 kategori (Technology, Lifestyle, Travel, Food)
- 8 tag (Ruby, Rails, React, JavaScript, Health, Fitness, Adventure, Recipe)
- 6 makale (5 yayınlanmış, 1 taslak)

## Sorun Giderme

### Backend çalışmıyor
```bash
rails server
```

### Database hatası
```bash
rails db:reset
```

### Gem eksik
```bash
bundle install
```

## Örnek Test Çıktısı

```
Feature: Kullanıcı Kimlik Doğrulama

  Senaryo: Yeni kullanıcı kaydı
    Eğer ki "John Doe" adında yeni bir kullanıcı kaydolmak istiyor
    Ve email adresi "john.test@example.com"
    Ve şifresi "password123"
    O zaman kayıt başarılı olmalı
    Ve JWT token almalı
    Ve kullanıcı bilgileri dönmeli

1 scenario (1 passed)
6 steps (6 passed)
0m0.532s
```

## Notlar

- Backend API'sinin çalışır durumda olması gerekir
- Testler `http://localhost:3000/api/v1` adresine istek atar
- Her test sonrası veritabanı temizlenir
- Test verileri otomatik olarak oluşturulur ve silinir

