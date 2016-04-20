$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'alfabank'
require 'vcr'
RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.before_record do |i|
    i.request.body.sub!(/userName=.+?&/, 'userName=username&')
    i.request.body.sub!(/password=.+?&/, 'password=qwerty&')
    i.response.body.sub!(/merchants\/.+\/payment/, 'merchants/merchant_name/payment')
  end
end
