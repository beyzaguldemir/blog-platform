#!/usr/bin/env ruby
# Veritabanı bağlantı kontrol scripti

require 'yaml'
require 'erb'

# database.yml dosyasını oku ve ERB template'lerini işle
db_config_path = File.join(__dir__, 'config', 'database.yml')
erb = ERB.new(File.read(db_config_path))
db_config = YAML.load(erb.result(binding))
dev_config = db_config['development']

puts "=" * 60
puts "Veritabanı Bağlantı Kontrolü"
puts "=" * 60
puts ""
puts "Yapılandırma:"
puts "  Host: #{dev_config['host']}"
puts "  Username: #{dev_config['username']}"
puts "  Database: #{dev_config['database']}"
puts ""

begin
  require 'mysql2'
  
  # MySQL bağlantısını test et
  client = Mysql2::Client.new(
    host: dev_config['host'],
    username: dev_config['username'],
    password: dev_config['password'],
    port: dev_config['port'] || 3306
  )
  
  puts "✅ MySQL sunucusuna başarıyla bağlanıldı!"
  puts ""
  
  # Veritabanının var olup olmadığını kontrol et
  databases = client.query("SHOW DATABASES LIKE '#{dev_config['database']}'").to_a
  
  if databases.empty?
    puts "⚠️  Veritabanı '#{dev_config['database']}' bulunamadı."
    puts ""
    puts "Veritabanını oluşturmak için:"
    puts "  bundle exec rails db:create"
    exit 1
  else
    puts "✅ Veritabanı '#{dev_config['database']}' mevcut."
    puts ""
    
    # Veritabanına bağlan ve tabloları kontrol et
    client.query("USE #{dev_config['database']}")
    tables = client.query("SHOW TABLES").to_a
    
    if tables.empty?
      puts "⚠️  Veritabanında tablo yok."
      puts ""
      puts "Migration'ları çalıştırmak için:"
      puts "  bundle exec rails db:migrate"
      exit 1
    else
      puts "✅ Veritabanında #{tables.length} tablo bulundu:"
      puts ""
      tables.each do |table|
        table_name = table.values.first
        count_result = client.query("SELECT COUNT(*) as cnt FROM #{table_name}").first
        count = count_result ? count_result['cnt'] : 0
        puts "  - #{table_name}: #{count} kayıt"
      end
      puts ""
      puts "✅ Veritabanı bağlantısı başarılı!"
      exit 0
    end
  end
  
rescue LoadError => e
  puts "❌ MySQL2 gem'i yüklü değil!"
  puts ""
  puts "Yüklemek için:"
  puts "  bundle install"
  exit 1
rescue Mysql2::Error => e
  puts "❌ MySQL bağlantı hatası: #{e.message}"
  puts ""
  puts "Olası sorunlar:"
  puts "  1. MySQL sunucusu çalışmıyor olabilir"
  puts "  2. Kullanıcı adı veya şifre yanlış olabilir"
  puts "  3. Host/Port ayarları yanlış olabilir"
  puts ""
  puts "Kontrol edin:"
  puts "  - MySQL servisinin çalıştığından emin olun"
  puts "  - config/database.yml dosyasındaki bilgileri kontrol edin"
  exit 1
rescue => e
  puts "❌ Hata: #{e.message}"
  puts e.backtrace.first(5)
  exit 1
ensure
  client&.close
end



