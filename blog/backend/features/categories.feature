# language: tr
Özellik: Kategori Yönetimi
  Blog platformunda kategori CRUD işlemleri

  Senaryo: Tüm kategorileri listeleme
    Eğer ki sistemde kategoriler var
    O zaman tüm kategoriler listelenebilmeli
    Ve kategori sayısı 0'dan büyük olmalı

  Senaryo: Yeni kategori oluşturma (Admin)
    Eğer ki admin olarak giriş yapılmış
    Ve "Technology" adında yeni bir kategori oluşturuyorum
    Ve açıklaması "Tech related posts"
    O zaman kategori başarıyla oluşturulmalı
    Ve kategorinin adı "Technology" olmalı

  Senaryo: Kategori güncelleme (Admin)
    Eğer ki admin olarak giriş yapılmış
    Ve sistemde "Technology" adında bir kategori var
    Ve kategori açıklaması "Updated description" olarak güncelleniyor
    O zaman güncelleme başarılı olmalı

  Senaryo: Kategori silme (Admin)
    Eğer ki admin olarak giriş yapılmış
    Ve sistemde silinebilir bir kategori var
    O zaman kategori silinebilmeli
    Ve "200" başarı kodu dönmeli

  Senaryo: Yetkisiz kullanıcı kategori oluşturamaz
    Eğer ki normal kullanıcı olarak giriş yapılmış
    Ve yeni bir kategori oluşturmaya çalışıyorum
    O zaman işlem reddedilmeli
    Ve "403" hata kodu dönmeli

