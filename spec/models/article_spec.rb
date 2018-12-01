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
end
