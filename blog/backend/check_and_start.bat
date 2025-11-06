@echo off
chcp 65001 >nul
echo === Blog Backend Başlatma ve Veritabanı Kontrolü ===
echo.

cd /d "%~dp0"
echo Çalışma dizini: %CD%
echo.

echo 1. Bundle bağımlılıklarını kontrol ediliyor...
if not exist "Gemfile.lock" (
    echo    Gemfile.lock bulunamadı, bundle install çalıştırılıyor...
    bundle install
    if errorlevel 1 (
        echo    [HATA] Bundle install başarısız!
        pause
        exit /b 1
    )
) else (
    echo    [OK] Gemfile.lock mevcut
)
echo.

echo 2. Veritabanı durumu kontrol ediliyor...
bundle exec rails db:version >nul 2>&1
if errorlevel 1 (
    echo    [UYARI] Veritabanı bağlantı sorunu tespit edildi
    echo    Veritabanını oluşturmak için çalıştırılıyor...
    bundle exec rails db:create
    if errorlevel 1 (
        echo    [HATA] Veritabanı oluşturulamadı!
        echo.
        echo    Lütfen şunları kontrol edin:
        echo    1. MySQL sunucusunun çalıştığından emin olun
        echo    2. config/database.yml dosyasındaki kullanıcı adı ve şifreyi kontrol edin
        echo    3. MySQL'de root kullanıcısının şifresi 'root' olmalı (veya database.yml'de güncelleyin)
        pause
        exit /b 1
    )
    echo    [OK] Veritabanı oluşturuldu!
    echo    Migration'lar çalıştırılıyor...
    bundle exec rails db:migrate
    if errorlevel 1 (
        echo    [HATA] Migration hatası!
        pause
        exit /b 1
    )
    echo    [OK] Migration'lar tamamlandı!
) else (
    bundle exec rails db:version
    echo    [OK] Veritabanı bağlantısı başarılı!
)
echo.

echo 3. Rails sunucusu başlatılıyor...
echo    Sunucu http://localhost:3000 adresinde çalışacak
echo    Durdurmak için Ctrl+C tuşlarına basın
echo.
bundle exec rails server



