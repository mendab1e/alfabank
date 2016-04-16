module Alfabank
  class Configuration
    class << self
      attr_accessor :username, :password, :language, :return_url
      attr_accessor :currency, :order_number_prefix, :mode
      attr_accessor :binding_username, :binding_password
    end
  end
end
