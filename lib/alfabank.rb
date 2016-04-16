require "alfabank/version"
require "alfabank/currency"
require "alfabank/api"
require "alfabank/configuration"

module Alfabank
  def register(binding_id = nil)
    Api::Registration.new(self).process(binding_id)
  end

  def check_status
    Api::Status.new(self).process
  end

  class << self
    attr_accessor :logger

    def setup(&block)
      yield Configuration
    end
  end
end
