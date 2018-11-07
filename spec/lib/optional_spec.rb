require 'rails_helper'

RSpec.describe Optional do
  describe 'self.none' do
    it 'creates a None object' do
      expect(described_class.none).to be_none
    end
  end

  describe 'self.some' do
    let(:article) { FactoryBot.build(:article) }

    it 'creates a Some object' do
      expect(described_class.some(article)).not_to be_none
    end

    it 'can retrieve the object' do
      optional = described_class.some(article)
      expect(optional.get).to eq(article)
    end
  end
end
