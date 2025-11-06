# 🚀 Hızlı Başlangıç Kılavuzu

Bu kılavuz, projeyi hızlıca çalıştırmanız için basit adımları içerir.

## ⚡ 3 Adımda Başlat

### 1️⃣ Backend'i Başlat

```bash
cd backend
bundle install
rails db:create db:migrate db:seed
rails server
```

Backend `http://localhost:3000` adresinde çalışacak.

### 2️⃣ Frontend'i Başlat

Yeni bir terminal açın:

```bash
cd frontend
npm install
npm run dev
```

Frontend `http://localhost:5173` adresinde çalışacak.

### 3️⃣ Giriş Yap

Tarayıcınızda `http://localhost:5173` adresine gidin.

**Admin olarak giriş:**
- Email: `admin@blog.com`
- Şifre: `password123`

**Kullanıcı olarak giriş:**
- Email: `john@blog.com`
- Şifre: `password123`

## 🎯 Ne Yapabilirsiniz?

### Admin Olarak:
- ✅ Tüm makaleleri görüntüle, oluştur, düzenle, sil
- ✅ Kategorileri yönet
- ✅ Tag'leri yönet
- ✅ Kullanıcıları yönet
- ✅ Tüm kullanıcıların makalelerini görebilir

### Normal Kullanıcı Olarak:
- ✅ Kendi makalelerini oluştur, düzenle, sil
- ✅ Yayınlanmış makaleleri görüntüle
- ✅ Makalelerine kategori ve tag ekle

## 🐛 Sorun mu var?

### Backend çalışmıyor?
```bash
# MySQL'in çalıştığından emin olun
# Veritabanı yapılandırmasını kontrol edin
cd backend
cat config/database.yml
```

### Frontend çalışmıyor?
```bash
# Node modüllerini temizleyin
cd frontend
rm -rf node_modules
npm install
```

### Port çakışması?
- Backend için: `config/puma.rb` dosyasından port'u değiştirin
- Frontend için: `vite.config.js` dosyasından port'u değiştirin

## 📚 Daha Fazla Bilgi

Detaylı bilgi için `README.md` dosyasına bakın.

---

**Keyifli Kodlamalar! 🎉**

