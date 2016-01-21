module Alfabank::Api
  class Status < Base
    TEST_URL = "https://test.paymentgate.ru/testpayment/rest/getOrderStatus.do"
    URL = "https://paymentgate.ru/payment/rest/getOrderStatus.do"
    PAID = 2

    def process
      response = make_request.parsed_response
      process_response(response)

      {
        order_status: response["OrderStatus"].to_i,
        binding_id: response["bindingId"],
        card_number: response["Pan"],
        error_code: response["ErrorCode"].to_i,
        error_message: response["ErrorMessage"]
      }
    rescue
      {error_message: 'Internal server error'}
    end

    private

    def process_response(response)
      if response["OrderStatus"].to_i == PAID
        payment.update_attribute(:paid, true)
      end
    end

    def generate_params
      {
        userName: Alfabank::Configuration.username,
        password: Alfabank::Configuration.password,
        orderId: payment.alfa_order_id
      }.map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
