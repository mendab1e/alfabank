Alfabank.setup do |config|
  config.username = 'username'
  config.password = 'password'
  config.language = 'ru'
  config.return_url = 'finish.html'
  config.currency = Alfabank::Currency::RUB
  config.order_number_prefix = 'payment-'
  config.binding_username = 'binding_username'
  config.mode = :test # :production
end
