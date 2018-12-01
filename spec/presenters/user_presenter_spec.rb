require 'rails_helper'

RSpec.describe UserPresenter do
  describe '#username' do
    context 'when user is active' do
      let(:user) do
        FactoryBot.build(:user, username: 'bob').presenter
      end

      it 'returns the username' do
        expect(user.username).to eq('bob')
      end
    end

    context 'when user is deleted' do
      let(:user) do
        user = FactoryBot.build(:user, username: 'bob')
        user.soft_delete
        user.presenter
      end

      it 'returns "deleted"' do
        expect(user.username).to eq('deleted')
      end
    end
  end
end
