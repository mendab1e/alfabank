module Alfabank
  class Configuration
    class << self
      attr_accessor :username, :password, :language, :return_url, :error_url
      attr_accessor :currency, :order_number_prefix, :binding_username, :mode
    end
  end
end
