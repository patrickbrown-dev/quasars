require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe '#create' do
    let(:voteable) { FactoryBot.create(:article) }
    let(:user) { FactoryBot.create(:user) }
    let(:params) do
      {
        voteable_id: voteable.id,
        voteable_type: voteable.class.to_s
      }
    end

    context 'when not logged in' do
      it 'does not increment karma' do
        post :create, params: params

        voteable.reload
        expect(voteable.karma).to eq(1)
      end
    end

    context 'when logged in' do
      before { sign_in user }

      it 'increments karma' do
        post :create, params: params

        voteable.reload
        expect(voteable.karma).to eq(2)
      end

      it 'creates a vote record' do
        post :create, params: params

        vote = Vote.find_by(user: user,
                            voteable_id: voteable.id,
                            voteable_type: voteable.class.to_s)

        expect(vote).not_to be_nil
      end

      it 'will not increment more than once' do
        post :create, params: params
        post :create, params: params

        voteable.reload
        expect(voteable.karma).to eq(2)
      end
    end
  end

  describe '#delete' do
    before { vote }

    let(:voteable) { FactoryBot.create(:article) }
    let(:user) { FactoryBot.create(:user) }
    let(:vote) { FactoryBot.create(:vote, user: user, voteable: voteable) }
    let(:params) do
      {
        voteable_id: voteable.id,
        voteable_type: voteable.class.to_s
      }
    end

    context 'when not logged in' do
      it 'does not decrement karma' do
        delete :destroy, params: params

        voteable.reload
        expect(voteable.karma).to eq(1)
      end
    end

    context 'when logged in' do
      before { sign_in user }

      it 'decrements karma' do
        delete :destroy, params: params

        voteable.reload
        expect(voteable.karma).to eq(0)
      end

      it 'deletes the vote record' do
        delete :destroy, params: params

        vote = Vote.find_by(user: user,
                            voteable_id: voteable.id,
                            voteable_type: voteable.class.to_s)

        expect(vote).to be_nil
      end

      it 'will not decrement more than once' do
        delete :destroy, params: params
        delete :destroy, params: params

        voteable.reload
        expect(voteable.karma).to eq(0)
      end
    end
  end
end
