require 'spec_helper'

class Payment
  attr_accessor :price, :alfa_order_id, :alfa_form_url, :paid, :description
  attr_accessor :user_id, :id

  def initialize(price: 100, description: 'Огурцы, салат и лук', user_id: 1)
    @id = 1
    @price = price
    @description = description
    @user_id = user_id
  end

  def update_attribute(attr, val)
    instance_variable_set("@#{attr}", val)
  end
end

describe Alfabank::Api::Status do
  before :each do
    prefix = (('a'..'z').to_a + ('A'..'Z').to_a).shuffle.take(12).join
    Alfabank.setup do |config|
      config.username = 'username'
      config.password = 'password'
      config.language = 'ru'
      config.return_url = 'finish.html'
      config.error_url = 'error.html'
      config.currency = Alfabank::Currency::RUB
      config.order_number_prefix = "payment-#{prefix}"
      config.binding_username = 'binding_username'
      config.mode = :test
    end
  end

  let(:payment) { Payment.new }
  let(:registration) { Alfabank::Api::Registration.new(payment) }
  subject { described_class.new(payment) }

  describe '#process' do
    context 'is not paid' do
      it 'works' do
        VCR.use_cassette("status_is_not_paid") do
          registration.process
          result = subject.process
          expect(payment.paid).to eq(nil)
          expect(result[:order_status]).to eq(0)
          expect(result[:error_code]).to eq(0)
        end
      end
    end

    context 'is paid' do
      it 'works' do
        VCR.use_cassette("status_is_paid") do
          payment.alfa_order_id = "0c60a275-1087-44d3-a96b-593f727b2c6a"
          result = subject.process
          expect(payment.paid).to eq(true)
          expect(result[:order_status]).to eq(Alfabank::Api::Status::PAID)
          expect(result[:error_code]).to eq(0)
          expect(result[:binding_id]).not_to eq(nil)
          expect(result[:card_number]).not_to eq(nil)
        end
      end
    end

    context 'wrong credentials' do
      it 'works' do
        payment.alfa_order_id = "123"
        VCR.use_cassette("status_wrong_credentials") do
          result = subject.process
          expect(result[:error_message]).to eq("Доступ запрещён")
          expect(result[:error_code]).to eq(5)
        end
      end
    end
  end
end
