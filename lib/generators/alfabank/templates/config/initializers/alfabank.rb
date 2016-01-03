Alfabank.setup do |config|
  config.user_name = "username"
  config.password = "password"
  config.language = "ru"
  config.return_url = "finish.html"
  config.error_url = "error.html"
  config.currency = Alfabank::Currency::RUB
end
