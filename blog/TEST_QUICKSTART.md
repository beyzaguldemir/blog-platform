# 🚀 Test Hızlı Başlangıç

## Backend API Testleri (Cucumber)

```bash
# Terminal 1 - Backend başlat
cd backend
rails server

# Terminal 2 - Testleri çalıştır
cd backend
cucumber
```

✅ **5 Feature, ~25 Senaryo**\
📝 Türkçe BDD senaryoları\
🎯 API endpoint testleri

---

## Frontend E2E Testleri (Cypress)

```bash
# Terminal 1 - Backend
cd backend
rails server

# Terminal 2 - Frontend
cd frontend
npm run dev

# Terminal 3 - Cypress testleri (Video kaydı ile)
cd frontend
npm run test:e2e
```

✅ **5 Test Dosyası, ~45 Test**\
🎬 Otomatik video kayıt\
📹 Videolar: `frontend/cypress/videos/`

---

## 📹 Video Kayıtları

Testler çalıştıktan sonra:
```
frontend/cypress/videos/
  ├── 01-authentication.cy.js.mp4   (Giriş/Kayıt)
  ├── 02-categories.cy.js.mp4       (Kategori Yönetimi)
  ├── 03-tags.cy.js.mp4             (Tag Yönetimi)
  ├── 04-posts.cy.js.mp4            (Makale Yönetimi)
  └── 05-users.cy.js.mp4            (Kullanıcı Yönetimi)
```

---

## 🎯 İnteraktif Test (UI ile)

```bash
cd frontend
npm run cypress:open
```

Cypress UI açılır → Testleri tek tek seçip izleyebilirsiniz!

---

## 📚 Detaylı Dokümantasyon

- **Tam Kılavuz:** [TESTING_GUIDE.md](TESTING_GUIDE.md)
- **Backend:** [backend/TESTING.md](backend/TESTING.md)
- **Frontend:** [frontend/TESTING.md](frontend/TESTING.md)

---

**Demo Hesaplar:**
- Admin: `admin@blog.com` / `password123`
- User: `john@blog.com` / `password123`

