require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { FactoryBot.build(:article) }

  it 'sets the uid before save' do
    article.save
    expect(article.uid).not_to be_nil
  end

  it 'sets the title before save' do
    article.save
    expect(article.title).not_to be_nil
  end

  describe '#host' do
    let(:article) { FactoryBot.build(:article, url: 'https://xkcd.com/314') }

    it 'returns the hostname from url' do
      expect(article.host).to eq('xkcd.com')
    end
  end
end
