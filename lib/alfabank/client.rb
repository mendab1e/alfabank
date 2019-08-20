module Alfabank
  class Client
    # https://web.rbsuat.com/ab/swagger/swagger.html#/register/registerOrderUsingPOST_7
    def self.register(order_number:, amount:, return_url:, options: {})
      params = options.merge(
        orderNumber: order_number,
        amount: amount,
        returnUrl: return_url
      )
      Alfabank::Request.new('register.do', params).perform
    end

    # https://web.rbsuat.com/ab/swagger/swagger.html#/status/getOrderStatusExtendedUsingPOST_1
    def self.status(order_id: nil, order_number: nil)
      raise ArgumentError if order_id.nil? && order_number.nil?

      params = { orderId: order_id, orderNumber: order_number }.compact
      Alfabank::Request.new('getOrderStatusExtended.do', params).perform
    end

    # https://pay.alfabank.ru/ecommerce/instructions/merchantManual/pages/index/rest.html#zapros_provedenija_platezha_po_svjazke_rest_
    def self.payment_order_binding(md_order:, binding_id:, ip:, options: {})
      params = options.merge(
        mdOrder: md_order,
        binding_id: bindingId,
        ip: ip
      )
      Alfabank::Request.new('paymentOrderBinding.do', params).perform
    end
  end
end
