module Alfabank::Api
  class Registration < Base
    TEST_URL = "https://test.paymentgate.ru/testpayment/rest/register.do"
    URL = "https://engine.paymentgate.ru/payment/rest/register.do"

    def process(binding_id = nil)
      return {url: payment.alfa_form_url} if payment.alfa_order_id
      @binding_id = binding_id

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
      params = {
        userName: Alfabank::Configuration.username,
        password: Alfabank::Configuration.password,
        description: payment.description,
        language: Alfabank::Configuration.language,
        orderNumber: "#{Alfabank::Configuration.order_number_prefix}#{payment.id}",
        amount: payment.price * 100,
        currency: Alfabank::Configuration.currency,
        clientId: payment.user_id,
        returnUrl: Alfabank::Configuration.return_url
      }

      if @binding_id
        params.merge!(
          userName: Alfabank::Configuration.binding_username,
          bindingId: @binding_id
        )
      end

      params.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def set_data_from_response(response)
      payment.update_attributes(
        alfa_order_id: response["orderId"],
        alfa_form_url: response["formUrl"]
      )
    end
  end
end
