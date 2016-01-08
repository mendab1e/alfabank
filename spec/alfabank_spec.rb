require 'spec_helper'

describe Alfabank do
  describe '.setup' do
    let(:username) { "Soryu Asuka" }

    it 'works' do
      described_class.setup { |config| config.username = username }
      expect(described_class::Configuration.username).to eq(username)
    end
  end
end
