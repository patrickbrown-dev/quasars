require 'spec_helper'

describe UrlValidator do
  context 'when an article has a correctly formatted url' do
    let(:article) { FactoryBot.build(:article, url: 'https://example.com') }

    it 'is valid' do
      expect(article).to be_valid
    end
  end

  context 'when an article has an incorrectly formatted url' do
    let(:article) { FactoryBot.build(:article, url: 'example.com') }

    it 'is invalid' do
      expect(article).not_to be_valid
    end
  end
end
