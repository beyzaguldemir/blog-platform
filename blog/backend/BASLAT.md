# Backend Başlatma ve Veritabanı Kontrolü

## Hızlı Başlatma

### 1. Backend dizinine geçin
```powershell
cd blog\backend
```

### 2. Bağımlılıkları yükleyin (eğer yapılmadıysa)
```powershell
bundle install
```

### 3. Veritabanı durumunu kontrol edin
```powershell
bundle exec rails db:version
```

### 4. Eğer veritabanı yoksa oluşturun
```powershell
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

### 5. Sunucuyu başlatın
```powershell
bundle exec rails server
```

## Otomatik Başlatma

Backend dizininde `check_and_start.bat` dosyasını çift tıklayarak otomatik başlatabilirsiniz.

## Veritabanı Yapılandırması

`config/database.yml` dosyasında:
- **Username:** root
- **Password:** root
- **Host:** 127.0.0.1
- **Database:** blog_development

MySQL'in çalıştığından ve root kullanıcısının şifresinin "root" olduğundan emin olun.

## Sorun Giderme

### MySQL bağlantı hatası
1. MySQL servisinin çalıştığını kontrol edin
2. `config/database.yml` dosyasındaki bilgileri kontrol edin
3. MySQL root şifresini kontrol edin

### Bundle install hatası
1. Ruby'nin yüklü olduğundan emin olun
2. `gem install bundler` komutunu çalıştırın
3. `bundle install` komutunu tekrar çalıştırın



