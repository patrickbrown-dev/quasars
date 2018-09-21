require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe '#index' do
    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    let(:article) { FactoryBot.create(:article) }

    it 'renders the index template' do
      get :show, params: { uid: article.uid }

      expect(response).to render_template(:show)
    end
  end

  describe '#new' do
    context 'when signed in' do
      before { sign_in user }

      let(:user) { FactoryBot.create(:user) }

      it 'renders the new template' do
        get :new

        expect(response).to render_template(:new)
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        get :new

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#edit' do
    let(:associated_user) { FactoryBot.create(:user) }
    let(:unassociated_user) { FactoryBot.create(:user) }
    let(:moderator_user) { FactoryBot.create(:user, :moderator) }

    let(:article) { FactoryBot.create(:article, user: associated_user) }

    context 'when associated user is signed in' do
      before { sign_in associated_user }

      it 'renders the edit template' do
        get :edit, params: { uid: article.uid }

        expect(response).to render_template(:edit)
      end
    end

    context 'when moderator user is signed in' do
      before { sign_in moderator_user }

      it 'renders the edit template' do
        get :edit, params: { uid: article.uid }

        expect(response).to render_template(:edit)
      end
    end

    context 'when unassociated user is signed in' do
      before { sign_in unassociated_user }

      it 'is forbidden' do
        get :edit, params: { uid: article.uid }

        expect(response).to be_forbidden
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        get :edit, params: { uid: article.uid }

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#create' do
    let(:user) { FactoryBot.create(:user) }
    let(:article_params) do
      FactoryBot.attributes_for(:article).merge(user_id: user.id)
    end

    context 'when signed in' do
      before { sign_in user }

      it 'renders the show template' do
        post :create, params: { article: article_params }

        article = Article.find_by(user: user)
        expect(response).to redirect_to(article_path(article.uid))
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :create, params: { article: article_params }

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#update' do
    let(:user) { FactoryBot.create(:user) }
    let(:moderator) { FactoryBot.create(:user, :moderator) }
    let(:article) { FactoryBot.create(:article, user: user) }
    let(:params) do
      { uid: article.uid, article: { description: 'New description' } }
    end

    context 'when associated user is signed in' do
      before { sign_in user }

      it 'renders the show template' do
        patch :update, params: params

        expect(response).to redirect_to(article_path(article.uid))
      end

      it 'updates the article' do
        patch :update, params: params

        expect(article.reload.description).to eq(params[:article][:description])
      end
    end

    context 'when moderator is signed in' do
      before { sign_in moderator }

      it 'renders the show template' do
        patch :update, params: params

        expect(response).to redirect_to(article_path(article.uid))
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        patch :update, params: params

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#destroy' do
    let(:associated_user) { FactoryBot.create(:user) }
    let(:unassociated_user) { FactoryBot.create(:user) }
    let(:moderator_user) { FactoryBot.create(:user, :moderator) }

    let(:article) { FactoryBot.create(:article, user: associated_user) }

    context 'when associated user is signed in' do
      before { sign_in associated_user }

      it 'redirects to the index' do
        delete :destroy, params: { uid: article.uid }

        expect(response).to redirect_to('/')
      end

      it 'destroys the article' do
        delete :destroy, params: { uid: article.uid }

        expect(Article.where(id: article.id)).to be_empty
      end
    end

    context 'when moderator user is signed in' do
      before { sign_in moderator_user }

      it 'destroys the article' do
        delete :destroy, params: { uid: article.uid }

        expect(Article.where(id: article.id)).to be_empty
      end
    end

    context 'when unassociated user is signed in' do
      before { sign_in unassociated_user }

      it 'is forbidden' do
        delete :destroy, params: { uid: article.uid }

        expect(response).to be_forbidden
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        delete :destroy, params: { uid: article.uid }

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
