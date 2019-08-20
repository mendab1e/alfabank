require 'httparty'

module Alfabank
  class Request
    BASE_URL = 'https://engine.paymentgate.ru/payment/rest/'
    TEST_BASE_URL = 'https://web.rbsuat.com/ab/rest/'

    def initialize(method, params)
      @method = method
      @params = default_params.merge(params)
    end

    def perform
      request = HTTParty.post(url, query: @params, format: :json)
      request.parsed_response
    end

    private

    def default_params
      {
        currency: Alfabank.config.currency,
        language: Alfabank.config.language,
        password: Alfabank.config.password,
        returnUrl: Alfabank.config.return_url,
        userName: Alfabank.config.userName
      }.compact
    end

    def url
      if Alfabank.config.environment.to_s == 'production'
        BASE_URL + @method
      else
        TEST_BASE_URL + @method
      end
    end
  end
end
