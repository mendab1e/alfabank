Alfabank.setup do |config|
  config.username = 'username'
  config.password = 'password'
  config.language = 'ru'
  config.return_url = 'finish.html'
  config.error_url = 'error.html'
  config.currency = Alfabank::Currency::RUB
  config.payment_number_prefix = 'payment-'
end
