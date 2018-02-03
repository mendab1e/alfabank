module Alfabank::Api
  class Registration < Base
    TEST_URL = 'https://web.rbsuat.com/ab/rest/register.do'
    URL = "https://engine.paymentgate.ru/payment/rest/register.do"

    def process(use_binding: false)
      return {url: payment.alfa_form_url} if payment.alfa_order_id
      @use_binding = use_binding

      process_response(make_request.parsed_response)
    rescue => e
      Alfabank.logger.error e
      {error: 'Internal server error'}
    end

    private

    def process_response(response)
      if response.has_key?("orderId")
        set_data_from_response(response)
        {url: payment.alfa_form_url}
      else
        {error: response['errorMessage']}
      end
    end

    def generate_params
      params = credentials.merge(
        description: payment.description,
        language: Alfabank::Configuration.language,
        orderNumber: order_number,
        amount: payment.price * 100,
        currency: Alfabank::Configuration.currency,
        clientId: payment.user_id,
        returnUrl: Alfabank::Configuration.return_url
      )

      params.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def set_data_from_response(response)
      payment.update_attributes(
        alfa_order_id: response["orderId"],
        alfa_form_url: response["formUrl"]
      )
    end

    def order_number
      number = payment.to_order_number rescue payment.id
      "#{Alfabank::Configuration.order_number_prefix}#{number}"
    end
  end
end
