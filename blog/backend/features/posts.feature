# language: tr
Özellik: Makale Yönetimi
  Blog platformunda makale CRUD işlemleri

  Senaryo: Yayınlanmış makaleleri listeleme
    Eğer ki sistemde yayınlanmış makaleler var
    O zaman sadece yayınlanmış makaleler listelenebilmeli

  Senaryo: Makale detayını görüntüleme
    Eğer ki sistemde bir makale var
    O zaman makale detayları görüntülenebilmeli
    Ve makale yazarı bilgileri dönmeli
    Ve makale kategorisi bilgileri dönmeli
    Ve makale tag'leri dönmeli

  Senaryo: Yeni makale oluşturma
    Eğer ki giriş yapılmış bir kullanıcı var
    Ve "Test Article" başlıklı yeni bir makale oluşturuyor
    Ve makale içeriği "This is test content"
    Ve bir kategori seçilmiş
    O zaman makale başarıyla oluşturulmalı
    Ve makale başlığı "Test Article" olmalı

  Senaryo: Makaleye tag ekleme
    Eğer ki giriş yapılmış bir kullanıcı var
    Ve yeni bir makale oluşturuyor
    Ve makaleye tag'ler ekliyor
    O zaman makale tag'leri ile birlikte kaydedilmeli

  Senaryo: Kendi makalesini güncelleme
    Eğer ki kullanıcının bir makalesi var
    Ve makale başlığını güncelliyor
    O zaman güncelleme başarılı olmalı

  Senaryo: Başkasının makalesini güncelleme (yetkisiz)
    Eğer ki bir kullanıcı giriş yapmış
    Ve başka bir kullanıcının makalesi var
    Ve o makaleyi güncellemeye çalışıyor
    O zaman işlem reddedilmeli
    Ve "403" hata kodu dönmeli

  Senaryo: Admin tüm makaleleri yönetebilir
    Eğer ki admin olarak giriş yapılmış
    Ve herhangi bir kullanıcının makalesi var
    O zaman admin makaleyi güncelleyebilmeli
    Ve admin makaleyi silebilmeli

  Senaryo: Makale yayınlama/taslak
    Eğer ki kullanıcının bir makalesi var
    Ve makale taslak olarak kaydediliyor
    O zaman makale "published" durumu "false" olmalı
    Ve makale yayınlanınca "published" durumu "true" olmalı

