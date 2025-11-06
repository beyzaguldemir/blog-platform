#!/usr/bin/env ruby
# Veritabanı bağlantı kontrol scripti

require 'yaml'
require 'mysql2'

# database.yml dosyasını oku
db_config = YAML.load_file('config/database.yml')
dev_config = db_config['development']

puts "Veritabanı yapılandırması:"
puts "  Host: #{dev_config['host']}"
puts "  Username: #{dev_config['username']}"
puts "  Database: #{dev_config['database']}"
puts ""

begin
  # MySQL bağlantısını test et
  client = Mysql2::Client.new(
    host: dev_config['host'],
    username: dev_config['username'],
    password: dev_config['password'],
    port: dev_config['port'] || 3306
  )
  
  puts "✅ MySQL sunucusuna başarıyla bağlanıldı!"
  
  # Veritabanının var olup olmadığını kontrol et
  databases = client.query("SHOW DATABASES LIKE '#{dev_config['database']}'").to_a
  
  if databases.empty?
    puts "⚠️  Veritabanı '#{dev_config['database']}' bulunamadı."
    puts "   Veritabanını oluşturmak için: rails db:create"
    exit 1
  else
    puts "✅ Veritabanı '#{dev_config['database']}' mevcut."
    
    # Veritabanına bağlan ve tabloları kontrol et
    client.query("USE #{dev_config['database']}")
    tables = client.query("SHOW TABLES").to_a
    
    if tables.empty?
      puts "⚠️  Veritabanında tablo yok. Migration'ları çalıştırmanız gerekiyor."
      puts "   Migration'ları çalıştırmak için: rails db:migrate"
      exit 1
    else
      puts "✅ Veritabanında #{tables.length} tablo bulundu:"
      tables.each do |table|
        table_name = table.values.first
        count = client.query("SELECT COUNT(*) as cnt FROM #{table_name}").first['cnt']
        puts "   - #{table_name} (#{count} kayıt)"
      end
      exit 0
    end
  end
  
rescue Mysql2::Error => e
  puts "❌ MySQL bağlantı hatası: #{e.message}"
  puts ""
  puts "Olası sorunlar:"
  puts "  1. MySQL sunucusu çalışmıyor olabilir"
  puts "  2. Kullanıcı adı veya şifre yanlış olabilir"
  puts "  3. Host/Port ayarları yanlış olabilir"
  exit 1
rescue => e
  puts "❌ Hata: #{e.message}"
  puts e.backtrace.first(3)
  exit 1
ensure
  client&.close
end



