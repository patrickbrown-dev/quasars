require 'rails_helper'

RSpec.describe AboutController, type: :controller do
  describe 'GET index' do
    it 'returns the about page' do
      get :index

      expect(response).to render_template(:index)
    end
  end
end
