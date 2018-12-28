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

  describe '#status' do
    context 'when user is active' do
      let(:user) do
        FactoryBot.build(:user).presenter
      end

      it 'returns "Active user"' do
        expect(user.status).to eq('Active user')
      end
    end

    context 'when user is deleted' do
      let(:user) do
        user = FactoryBot.build(:user)
        user.soft_delete
        user.presenter
      end

      it 'returns "User account deactivated"' do
        expect(user.status).to eq('User account deactivated')
      end
    end
  end

  describe '#priviledges' do
    context 'when user is a moderator' do
      let(:user) { FactoryBot.build(:user, :moderator).presenter }

      it 'returns "Moderator"' do
        expect(user.priviledges).to eq('Moderator')
      end
    end

    context 'when user is not a moderator' do
      let(:user) { FactoryBot.build(:user).presenter }

      it 'returns "User"' do
        expect(user.priviledges).to eq('User')
      end
    end
  end
end
