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
  end
end
