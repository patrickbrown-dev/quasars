require 'rails_helper'

RSpec.describe FeedController, type: :controller do
  describe '#index' do
    let(:time) { Time.utc(2019, 1, 20, 20, 3, 15) }

    let!(:article) do
      Timecop.freeze(time) do
        FactoryBot.create(:article)
      end
    end

    it 'returns a successful response' do
      get :index
      expect(response.code).to eq('200')
    end

    describe 'entry' do
      it 'includes the article uid' do
        get :index
        expect(response.body).to include("<id>#{article.uid}</id>")
      end

      it 'includes the article url' do
        get :index
        expect(response.body)
          .to include("<link href=\"#{article_url(article.uid)}\"/>")
      end

      it 'includes the article description' do
        get :index
        expect(response.body)
          .to include("<summary>#{article.description}</summary>")
      end

      it 'includes the article title' do
        get :index
        expect(response.body)
          .to include("<title>#{article.title}</title>")
      end

      it 'includes the article created_at' do
        get :index
        expect(response.body)
          .to include('<updated>2019-01-20T20:03:15Z</updated>')
      end
    end
  end
end
