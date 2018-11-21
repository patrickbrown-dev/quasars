require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe '#karma' do
    it "is the sum of a user's article and comment karma" do
      FactoryBot.create(:article, user: user, karma: 1)
      FactoryBot.create(:comment, user: user, karma: 2)

      expect(user.karma).to eq(3)
    end
  end

  describe '#soft_delete' do
    it "sets the user's deleted_at field" do
      user.soft_delete

      expect(user.deleted_at).not_to be_nil
    end
  end

  describe '#inactive_message' do
    context 'when an user is active' do
      it 'returns :inactive' do
        expect(user.inactive_message).to eq(:inactive)
      end
    end

    context 'when an user is soft deleted' do
      it 'returns :deleted_account' do
        user.soft_delete
        expect(user.inactive_message).to eq(:deleted_account)
      end
    end
  end
end
