require 'spec_helper'

class Payment
  attr_accessor :price, :alfa_order_id, :alfa_form_url, :payed, :description
  attr_accessor :user_id, :id

  def initialize(price: 100, description: 'Огурцы, салат и лук', user_id: 1)
    @id = 1
    @price = price
    @description = description
    @user_id = user_id
  end

  def update_attributes(alfa_order_id:, alfa_form_url:)
    @alfa_order_id = alfa_order_id
    @alfa_form_url = alfa_form_url
  end
end

describe Alfabank::Api::Registration do
  before :each do
    prefix = (('a'..'z').to_a + ('A'..'Z').to_a).shuffle.take(12).join
    Alfabank.setup do |config|
      config.username = 'username'
      config.password = 'password'
      config.language = 'ru'
      config.return_url = 'finish.html'
      config.error_url = 'error.html'
      config.currency = Alfabank::Currency::RUB
      config.payment_number_prefix = "payment-#{prefix}"
      config.binding_username = 'binding_username'
    end
  end

  let(:payment) { Payment.new }
  subject { described_class.new(payment) }

  describe '#process' do
    it 'works' do
      VCR.use_cassette("registration") do
        expect(subject.process).not_to eq(nil)
      end
    end
  end
end
