require 'spec_helper'

class Payment
  include Alfabank
end

describe Alfabank do
  let(:payment) { Payment.new }

  describe '.setup' do
    let(:username) { "Soryu Asuka" }

    it 'works' do
      described_class.setup { |config| config.username = username }
      expect(described_class::Configuration.username).to eq(username)
    end
  end

  describe '#register' do
    it 'works' do
      expect(Alfabank::Api::Registration).to receive(:new).with(payment).and_call_original
      expect_any_instance_of(Alfabank::Api::Registration).to receive(:process)
      payment.register
    end
  end

  describe '#check_status' do
    it 'works' do
      expect(Alfabank::Api::Status).to receive(:new).with(payment).and_call_original
      expect_any_instance_of(Alfabank::Api::Status).to receive(:process)
      payment.check_status
    end
  end
end
