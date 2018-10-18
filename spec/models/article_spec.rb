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

  describe '#description_only?' do
    context 'when there is only a description' do
      let(:article) do
        FactoryBot.build(:article,
                         description: 'description',
                         url: '')
      end

      it 'returns true' do
        expect(article).to be_description_only
      end
    end

    context 'when there is a description + url' do
      let(:article) do
        FactoryBot.build(:article,
                         description: 'description',
                         url: 'https://xkcd.com/314')
      end

      it 'returns true' do
        expect(article).not_to be_description_only
      end
    end

    context 'when there is a no description' do
      let(:article) do
        FactoryBot.build(:article,
                         description: '',
                         url: 'https://xkcd.com/314')
      end

      it 'returns true' do
        expect(article).not_to be_description_only
      end
    end
  end

  describe '#host' do
    let(:article) { FactoryBot.build(:article, url: 'https://xkcd.com/314') }

    it 'returns the hostname from url' do
      expect(article.host).to eq('xkcd.com')
    end
  end
end
