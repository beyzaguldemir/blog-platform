# language: tr
Özellik: Kullanıcı Yönetimi
  Blog platformunda kullanıcı yönetimi (Admin)

  Senaryo: Tüm kullanıcıları listeleme (Admin)
    Eğer ki admin olarak giriş yapılmış
    O zaman tüm kullanıcılar listelenebilmeli
    Ve kullanıcı sayısı 0'dan büyük olmalı

  Senaryo: Kullanıcı silme (Admin)
    Eğer ki admin olarak giriş yapılmış
    Ve sistemde silinebilir bir kullanıcı var
    O zaman admin kullanıcıyı silebilmeli

  Senaryo: Normal kullanıcı diğer kullanıcıları görüntüleyemez
    Eğer ki normal kullanıcı olarak giriş yapılmış
    Ve tüm kullanıcıları listelemeye çalışıyor
    O zaman işlem reddedilmeli
    Ve "403" hata kodu dönmeli

  Senaryo: Kullanıcı kendi bilgilerini güncelleyebilir
    Eğer ki giriş yapılmış bir kullanıcı var
    Ve kendi adını güncelliyor
    O zaman güncelleme başarılı olmalı

  Senaryo: Kullanıcı başkasının bilgilerini güncelleyemez
    Eğer ki bir kullanıcı giriş yapmış
    Ve başka bir kullanıcının bilgilerini güncellemeye çalışıyor
    O zaman işlem reddedilmeli

