module Alfabank
  class Configuration
    class << self
      attr_accessor :username, :password, :language, :return_url
      attr_accessor :currency, :order_number_prefix, :mode
      attr_accessor :binding_username, :binding_password

      def binding_credentials
        {
          userName: binding_username,
          password: binding_password
        }
      end

      def common_credentials
        {
          userName: username,
          password: password
        }
      end
    end
  end
end
