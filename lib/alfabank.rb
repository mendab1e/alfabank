require "alfabank/version"
require "alfabank/currency"
require "alfabank/api"
require "alfabank/configuration"

module Alfabank
  def register
    Api::Registration.new(self).process
  end

  def check_status
    Api::Status.new(self).process
  end

  def payment_order_binding(binding_id)
    Api::PaymentOrderBinding.new(self).process(binding_id)
  end

  class << self
    attr_accessor :logger

    def setup(&block)
      yield Configuration
    end
  end
end
