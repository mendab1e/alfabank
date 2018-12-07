module Alfabank
  class Response
    ORDER_STATUS_APPROVED = 2

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def approved?
      @data['orderStatus'] == ORDER_STATUS_APPROVED
    end
  end
end
