# Blog Platform - Frontend (React)

Modern React ve Tailwind CSS ile geliştirilmiş blog frontend'i.

## Özellikler

- Modern ve responsive tasarım
- JWT authentication
- Admin paneli
- Kategori, tag ve post yönetimi
- Protected routes
- Tailwind CSS styling

## Kurulum

```bash
# Bağımlılıkları yükle
npm install

# Development sunucusunu başlat
npm run dev

# Production build
npm run build
```

## Kullanılan Teknolojiler

- React 18
- Vite
- React Router DOM
- Axios
- Tailwind CSS

## API Bağlantısı

Frontend, `http://localhost:3000/api/v1` adresindeki backend API'sine bağlanır.

Bağlantı ayarları `src/api/axios.js` dosyasında yapılandırılmıştır.

## Development

```bash
npm run dev
```

Uygulama `http://localhost:5173` adresinde çalışır.
