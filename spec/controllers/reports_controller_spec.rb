require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe '#index' do
    context 'when moderator is signed in' do
      before { sign_in(user) }

      let(:user) { FactoryBot.create(:user, :moderator) }

      it 'renders the index template' do
        get :index

        expect(response).to render_template(:index)
      end
    end

    context 'when regular user is signed in' do
      before { sign_in(user) }

      let(:user) { FactoryBot.create(:user) }

      it 'is not found' do
        expect do
          get :index
        end.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end

    context 'when not signed in' do
      it 'is not found' do
        expect do
          get :index
        end.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end
  end

  describe '#show' do
    let(:report) { FactoryBot.create(:report) }

    context 'when moderator is signed in' do
      before { sign_in(user) }

      let(:user) { FactoryBot.create(:user, :moderator) }

      it 'renders the show template' do
        get :show, params: { id: report.id }

        expect(response).to render_template(:show)
      end
    end

    context 'when regular user is signed in' do
      before { sign_in(user) }

      let(:user) { FactoryBot.create(:user) }

      it 'is not found' do
        expect do
          get :show, params: { id: report.id }
        end.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end

    context 'when not signed in' do
      it 'is not found' do
        expect do
          get :show, params: { id: report.id }
        end.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end
  end

  describe '#new' do
    let(:user) { FactoryBot.create(:user) }
    let(:article) { FactoryBot.create(:article) }
    let(:params) do
      { report: { reportable_id: article.id,
                  reportable_type: article.class.to_s } }
    end

    context 'when user is signed in' do
      before { sign_in(user) }

      it 'renders the new template' do
        get :new, params: params

        expect(response).to render_template(:new)
      end
    end

    context 'when not signed in' do
      it 'redirects to user sign in' do
        get :new, params: params

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#create' do
    let(:user) { FactoryBot.create(:user) }
    let(:article) { FactoryBot.create(:article) }
    let(:params) do
      {
        report: FactoryBot.attributes_for(:report).merge(
          reportable_id: article.id,
          reportable_type: article.class.to_s
        )
      }
    end

    context 'when user is signed in' do
      before { sign_in(user) }

      it 'redirects to the index' do
        post :create, params: params

        expect(response).to redirect_to('/')
      end

      it 'creates the report' do
        post :create, params: params

        report = Report.find_by(user: user.id)
        expect(report).not_to be_nil
      end
    end

    context 'when not signed in' do
      it 'redirects to user sign in' do
        post :create, params: params

        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#resolve' do
    let(:user) { FactoryBot.create(:user) }
    let(:moderator) { FactoryBot.create(:user, :moderator) }
    let(:report) { FactoryBot.create(:report) }

    context 'when moderator is signed in' do
      before { sign_in(moderator) }

      it 'redirects to the reports index' do
        post :resolve, params: { id: report.id }

        expect(response).to redirect_to(reports_path)
      end
    end

    context 'when regular user is signed in' do
      before { sign_in(user) }

      it 'is not found' do
        expect do
          post :resolve, params: { id: report.id }
        end.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end

    context 'when not signed in' do
      it 'is not found' do
        expect do
          post :resolve, params: { id: report.id }
        end.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end
  end
end
