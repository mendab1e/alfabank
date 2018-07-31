require 'httparty'

module Alfabank::Api
  class Base
    attr_reader :payment, :use_binding

    def initialize(payment)
      @payment = payment
    end

    private

    def make_request
      HTTParty.post(url, body: generate_params, format: :json)
    end

    def generate_params
      fail NotImplementedError, "this method should be overridden"
    end

    def url
      Alfabank::Configuration.mode.to_s == 'production' ? self.class::URL : self.class::TEST_URL
    end

    def credentials
      if use_binding
        Alfabank::Configuration.binding_credentials
      else
        Alfabank::Configuration.common_credentials
      end
    end
  end
end
