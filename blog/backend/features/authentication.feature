# language: tr
Özellik: Kullanıcı Kimlik Doğrulama
  Blog platformunda kullanıcı kaydı ve giriş işlemleri

  Senaryo: Yeni kullanıcı kaydı
    Eğer ki "John Doe" adında yeni bir kullanıcı kaydolmak istiyor
    Ve email adresi "john.test@example.com"
    Ve şifresi "password123"
    O zaman kayıt başarılı olmalı
    Ve JWT token almalı
    Ve kullanıcı bilgileri dönmeli

  Senaryo: Mevcut kullanıcı girişi
    Eğer ki sistemde "admin@blog.com" email'li bir kullanıcı var
    Ve doğru şifre "password123" ile giriş yapıyor
    O zaman giriş başarılı olmalı
    Ve JWT token almalı
    Ve kullanıcı rolü "admin" olmalı

  Senaryo: Hatalı şifre ile giriş
    Eğer ki sistemde "admin@blog.com" email'li bir kullanıcı var
    Ve yanlış şifre "wrongpassword" ile giriş yapıyor
    O zaman giriş başarısız olmalı
    Ve "401" hata kodu dönmeli

