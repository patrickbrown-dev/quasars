require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    let(:user) { FactoryBot.create(:user) }

    it 'renders the show template' do
      get :show, params: { username: user.username }

      expect(response).to render_template(:show)
    end
  end
end
