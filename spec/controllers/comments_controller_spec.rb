require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#edit' do
    let(:associated_user) { FactoryBot.create(:user) }
    let(:unassociated_user) { FactoryBot.create(:user) }
    let(:moderator_user) { FactoryBot.create(:user, :moderator) }

    let(:article) { FactoryBot.create(:article) }
    let(:comment) do
      FactoryBot.create(:comment, article: article, user: associated_user)
    end

    context 'when associated user is signed in' do
      before { sign_in associated_user }

      it 'renders the edit template' do
        get :edit, params: { id: comment.id }

        expect(response).to render_template(:edit)
      end
    end

    context 'when moderator user is signed in' do
      before { sign_in moderator_user }

      it 'renders the edit template' do
        get :edit, params: { id: comment.id }

        expect(response).to render_template(:edit)
      end
    end

    context 'when unassociated user is signed in' do
      before { sign_in unassociated_user }

      it 'is forbidden' do
        get :edit, params: { id: comment.id }

        expect(response).to be_forbidden
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        get :edit, params: { id: comment.id }

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#create' do
    let(:user) { FactoryBot.create(:user) }
    let(:article) { FactoryBot.create(:article) }
    let(:comment_params) do
      FactoryBot
        .attributes_for(:comment)
        .merge(user_id: user.id, article_id: article.id)
    end

    context 'when signed in' do
      before { sign_in user }

      it 'creates the comment' do
        post :create, params: { comment: comment_params }

        comment = Comment.find_by(user: user)
        expect(comment).not_to be_nil
      end

      it "redirects to the comment's article" do
        post :create, params: { comment: comment_params }

        expect(response).to redirect_to(article_path(article.uid))
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        post :create, params: { comment: comment_params }

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#update' do
    let(:user) { FactoryBot.create(:user) }
    let(:moderator) { FactoryBot.create(:user, :moderator) }
    let(:article) { FactoryBot.create(:article) }
    let(:comment) { FactoryBot.create(:comment, user: user, article: article) }
    let(:params) do
      { id: comment.id, comment: { body: 'New body!' } }
    end

    context 'when associated user is signed in' do
      before { sign_in user }

      it "renders the article's show template" do
        patch :update, params: params

        expect(response).to redirect_to(article_path(article.uid))
      end

      it 'updates the comment' do
        patch :update, params: params

        expect(comment.reload.body).to eq(params[:comment][:body])
      end
    end

    context 'when moderator is signed in' do
      before { sign_in moderator }

      it "renders the article's show template" do
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
    let(:article) { FactoryBot.create(:article) }

    let(:comment) do
      FactoryBot.create(:comment, article: article, user: associated_user)
    end

    context 'when associated user is signed in' do
      before { sign_in associated_user }

      it "redirects to the article's show template" do
        delete :destroy, params: { id: comment.id }

        expect(response).to redirect_to(article_path(article.uid))
      end

      it 'destroys the comment' do
        delete :destroy, params: { id: comment.id }

        expect(Comment.where(id: comment.id)).to be_empty
      end
    end

    context 'when moderator user is signed in' do
      before { sign_in moderator_user }

      it 'destroys the comment' do
        delete :destroy, params: { id: comment.id }

        expect(Comment.where(id: comment.id)).to be_empty
      end
    end

    context 'when unassociated user is signed in' do
      before { sign_in unassociated_user }

      it 'is forbidden' do
        delete :destroy, params: { id: comment.id }

        expect(response).to be_forbidden
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        delete :destroy, params: { id: comment.id }

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
