# Backend başlatma ve veritabanı kontrol scripti

$ErrorActionPreference = "Stop"

Write-Host "=== Blog Backend Başlatma ve Veritabanı Kontrolü ===" -ForegroundColor Cyan
Write-Host ""

# Backend dizinine geç
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath
Write-Host "Çalışma dizini: $(Get-Location)" -ForegroundColor Yellow
Write-Host ""

# Bundle install kontrolü
Write-Host "1. Bundle bağımlılıklarını kontrol ediliyor..." -ForegroundColor Cyan
if (-not (Test-Path "Gemfile.lock")) {
    Write-Host "   Gemfile.lock bulunamadı, bundle install çalıştırılıyor..." -ForegroundColor Yellow
    bundle install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "   ❌ Bundle install başarısız!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "   ✅ Gemfile.lock mevcut" -ForegroundColor Green
}
Write-Host ""

# Veritabanı versiyon kontrolü
Write-Host "2. Veritabanı durumu kontrol ediliyor..." -ForegroundColor Cyan
try {
    $dbVersion = bundle exec rails db:version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Veritabanı bağlantısı başarılı!" -ForegroundColor Green
        Write-Host "   $dbVersion" -ForegroundColor Gray
    } else {
        Write-Host "   ⚠️  Veritabanı bağlantı sorunu tespit edildi" -ForegroundColor Yellow
        Write-Host "   $dbVersion" -ForegroundColor Gray
    }
} catch {
    Write-Host "   ❌ Veritabanı bağlantı hatası: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "   Veritabanını oluşturmak için çalıştırılıyor..." -ForegroundColor Yellow
    bundle exec rails db:create
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Veritabanı oluşturuldu!" -ForegroundColor Green
        Write-Host "   Migration'lar çalıştırılıyor..." -ForegroundColor Yellow
        bundle exec rails db:migrate
        if ($LASTEXITCODE -eq 0) {
            Write-Host "   ✅ Migration'lar tamamlandı!" -ForegroundColor Green
        } else {
            Write-Host "   ❌ Migration hatası!" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "   ❌ Veritabanı oluşturulamadı!" -ForegroundColor Red
        Write-Host ""
        Write-Host "   Lütfen şunları kontrol edin:" -ForegroundColor Yellow
        Write-Host "   1. MySQL sunucusunun çalıştığından emin olun" -ForegroundColor Yellow
        Write-Host "   2. config/database.yml dosyasındaki kullanıcı adı ve şifreyi kontrol edin" -ForegroundColor Yellow
        Write-Host "   3. MySQL'de root kullanıcısının şifresi 'root' olmalı (veya database.yml'de güncelleyin)" -ForegroundColor Yellow
        exit 1
    }
}
Write-Host ""

# Rails sunucusunu başlat
Write-Host "3. Rails sunucusu başlatılıyor..." -ForegroundColor Cyan
Write-Host "   Sunucu http://localhost:3000 adresinde çalışacak" -ForegroundColor Yellow
Write-Host "   Durdurmak için Ctrl+C tuşlarına basın" -ForegroundColor Yellow
Write-Host ""
bundle exec rails server



