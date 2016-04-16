Alfabank.setup do |config|
  config.username = 'username'
  config.password = 'password'
  config.language = 'ru'
  config.return_url = 'finish.html'
  config.currency = Alfabank::Currency::RUB
  config.order_number_prefix = 'payment-'
  config.binding_username = 'binding_username'
  config.binding_password = 'binding_password'
  config.mode = :test # :production
end

Alfabank.logger = Rails.logger
