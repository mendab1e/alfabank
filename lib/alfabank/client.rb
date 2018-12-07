module Alfabank
  class Client
    # https://web.rbsuat.com/ab/swagger/swagger.html#/register/registerOrderUsingPOST_7
    def register(order_number:, amount:, return_url:, options: {})
      params = options.merge(
        order_number: order_number,
        amount: amount,
        return_url: return_url
      )
      Alfabank::Request.new('register.do', params).perform
    end
  end
end
