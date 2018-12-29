require 'rails_helper'

RSpec.describe ArticlePresenter do
  describe '#title' do
    context 'when article is sticky' do
      let(:article) { FactoryBot.build(:article, is_sticky: true).presenter }

      it 'includes "Sticky" in the beginning of title' do
        expect(article.title).to match(/Sticky: /)
      end
    end

    context 'when article is not sticky' do
      let(:article) { FactoryBot.build(:article, is_sticky: false).presenter }

      it 'includes "Sticky" in the beginning of title' do
        expect(article.title).not_to match(/Sticky: /)
      end
    end
  end

  describe '#host' do
    let(:article) do
      FactoryBot.build(:article, url: 'https://xkcd.com/314').presenter
    end

    it 'returns the hostname from url' do
      expect(article.host).to eq('xkcd.com')
    end
  end

  describe '#description_only?' do
    context 'when there is only a description' do
      let(:article) do
        FactoryBot.build(:article,
                         description: 'description',
                         url: '').presenter
      end

      it 'returns true' do
        expect(article).to be_description_only
      end
    end

    context 'when there is a description + url' do
      let(:article) do
        FactoryBot.build(:article,
                         description: 'description',
                         url: 'https://xkcd.com/314').presenter
      end

      it 'returns true' do
        expect(article).not_to be_description_only
      end
    end

    context 'when there is a no description' do
      let(:article) do
        FactoryBot.build(:article,
                         description: '',
                         url: 'https://xkcd.com/314').presenter
      end

      it 'returns true' do
        expect(article).not_to be_description_only
      end
    end
  end
end
