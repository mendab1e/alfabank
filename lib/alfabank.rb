require "alfabank/version"
require "alfabank/currency"
require "alfabank/api"
require "alfabank/configuration"

module Alfabank
  class << self
    def setup(&block)
      yield Configuration
    end
  end
end
