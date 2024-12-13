require 'rest-client'
require 'json'
require 'dotenv'

Dotenv.load

API_KEY = ENV["API_KEY"]
BASE_URL = "https://v6.exchangerate-api.com/v6/#{API_KEY}/latest/TRY"

# API anahtarını kontrol et
if API_KEY.nil? || API_KEY.empty?
  puts "API anahtarınız eksik veya geçersiz. Lütfen .env dosyasını kontrol edin."
  exit
end

def get_info(para_birimi)
  begin
    response = RestClient.get(BASE_URL)
    data = JSON.parse(response.body)

    if data["result"] == "success"
      rates = data["conversion_rates"]
      if rates.key?(para_birimi)
        puts "#{para_birimi} kuru: #{rates[para_birimi]}"
      else
        puts "Geçersiz para birimi!"
      end
    else
      puts "API'den veri alınırken bir hata oluştu: #{data['error-type']}"
    end
  rescue RestClient::ExceptionWithResponse => e
    puts "API isteği sırasında bir hata oluştu: #{e.response}"
  rescue StandardError => e
    puts "Beklenmeyen bir hata oluştu: #{e.message}"
  end
end

while true
  puts "\nDöviz kuru öğrenmek istediğiniz para birimini girin (örneğin EUR, GBP, TRY) veya çıkmak için 'çık' yazın:"
  birim = gets.chomp.upcase

  # Çıkış yapmayı sağla
  if birim == 'ÇIK'
    puts "Çıkılıyor..."
    break
  end

  get_info(birim)
end
