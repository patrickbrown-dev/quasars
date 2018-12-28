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

  context 'when an article description and url are empty' do
    let(:article) { FactoryBot.build(:article, url: '', description: '') }

    it 'is invalid' do
      expect(article).not_to be_valid
    end
  end
end
