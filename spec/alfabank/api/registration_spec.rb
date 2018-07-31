require 'spec_helper'
require 'payment_mock'

describe Alfabank::Api::Registration do
  before :each do
    prefix = (('a'..'z').to_a + ('A'..'Z').to_a).shuffle.take(12).join
    Alfabank.setup do |config|
      config.username = 'username'
      config.password = 'password'
      config.language = 'ru'
      config.return_url = 'finish.html'
      config.currency = Alfabank::Currency::RUB
      config.order_number_prefix = "payment-#{prefix}"
      config.binding_username = 'binding_username'
      config.mode = :test
    end
    allow(Alfabank.logger).to receive(:error)
  end

  let(:payment) { PaymentMock.new }
  subject { described_class.new(payment) }

  describe '#process' do
    it 'works' do
      VCR.use_cassette("registration") do
        result = subject.process
        expect(result[:url]).not_to eq(nil)
        expect(result[:error]).to eq(nil)
        expect(payment.alfa_form_url).to eq(result[:url])
        expect(payment.alfa_order_id).not_to eq(nil)
      end
    end

    context 'payment has alfa_order_id' do
      before :each do
        payment.alfa_order_id = "order-1"
        payment.alfa_form_url = "url"
      end

      it 'works' do
        expect(subject).not_to receive(:process_response)
        expect(subject.process[:url]).to eq(payment.alfa_form_url)
      end
    end

    context 'order_number is not uniq' do
      let(:first_obj) { described_class.new(PaymentMock.new) }

      it 'works' do
        VCR.use_cassette("order_number_is_not_uniq") do
          result = first_obj.process
          expect(result[:url]).not_to eq(nil)
          expect(result[:error]).to eq(nil)

          expect(subject.process[:error]).to eq("Заказ с таким номером уже обработан")
        end
      end
    end

    context 'wrong credentials' do
      it 'works' do
        VCR.use_cassette("wrong_credentials") do
          result = subject.process
          expect(result[:url]).to eq(nil)
          expect(result[:error]).to eq("Доступ запрещён")
        end
      end
    end
  end
end
