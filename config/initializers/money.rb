
MoneyRails.configure do |config|
  config.default_currency = :sek

  config.add_rate 'USD', 'SEK', 1
end


