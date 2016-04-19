module Alfabank::Api
  class Status < Base
    TEST_URL = "https://test.paymentgate.ru/testpayment/rest/getOrderStatus.do"
    URL = "https://engine.paymentgate.ru/payment/rest/getOrderStatus.do"
    PAID = 2

    def process(use_binding: false)
      @use_binding = use_binding

      response = make_request.parsed_response
      process_response(response)

      {
        order_status: response["OrderStatus"].to_i,
        binding_id: response["bindingId"],
        card_number: response["Pan"],
        error_code: response["ErrorCode"].to_i,
        error_message: response["ErrorMessage"]
      }
    rescue => e
      Alfabank.logger.error e
      {error_message: 'Internal server error'}
    end

    private

    def process_response(response)
      return unless response["OrderStatus"].to_i == PAID

      payment.paid = true
      payment.binding_id = response["bindingId"] if payment.respond_to?(:binding_id)
      payment.card_number = response["Pan"] if payment.respond_to?(:card_number)
      payment.save(validate: false)
    end

    def generate_params
      credentials.merge(orderId: payment.alfa_order_id).map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
