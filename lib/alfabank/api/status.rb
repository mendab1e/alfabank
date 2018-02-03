module Alfabank::Api
  class Status < Base
    TEST_URL = 'https://web.rbsuat.com/ab/rest/getOrderStatus.do'
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
    end

    private

    def process_response(response)
      return unless response["OrderStatus"].to_i == PAID

      payment.paid = true
      payment.card_number = response["Pan"] if payment.respond_to?(:card_number)
      if payment.respond_to?(:binding_id)
        payment.binding_id = response["bindingId"]
      end
      payment.save(validate: false)
    end

    def generate_params
      credentials.merge(orderId: payment.alfa_order_id).map do |k, v|
        "#{k}=#{v}"
      end.join('&')
    end
  end
end
