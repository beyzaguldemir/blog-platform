# Blog Platform - Backend (Rails API)

Ruby on Rails 8.1 ile geliştirilmiş RESTful API.

## Özellikler

- JWT tabanlı authentication
- User, Category, Tag, Post modelleri
- Role-based access control (Admin/User)
- MySQL veritabanı
- CORS desteği

## Kurulum

```bash
# Bağımlılıkları yükle
bundle install

# Veritabanını oluştur
rails db:create

# Migration'ları çalıştır
rails db:migrate

# Seed verilerini yükle (opsiyonel)
rails db:seed

# Sunucuyu başlat
rails server
```

## API Endpoints

Tüm API endpoint'leri için ana README.md dosyasına bakın.

## Veritabanı Yapılandırması

`config/database.yml` dosyasında MySQL kullanıcı adı ve şifrenizi ayarlayın:

```yaml
default: &default
  adapter: mysql2
  encoding: utf8mb4
  username: root
  password: root
  host: 127.0.0.1
```

## Test

```bash
# Testleri çalıştır (şu an için test yoktur)
rails test
```
