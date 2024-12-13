require 'rest-client'
require 'json'


API_KEY = 'b814a9062226ad99cbaf4a72'
BASE_URL = "https://v6.exchangerate-api.com/v6/#{API_KEY}/latest/USD"

def get_info(para_birimi)
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
    puts "API'den veri alınırken bir hata oluştu."
  end
end

while true
    puts "\nDöviz kuru öğrenmek istediğiniz para birimini girin (örneğin EUR, GBP, TRY):"
    birim = gets.chomp.upcase

    get_info(birim)
end