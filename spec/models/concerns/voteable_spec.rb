require 'rails_helper'

RSpec.describe Voteable do
  describe '#upvoted_by_user?' do
    let(:user) { FactoryBot.build(:user) }
    let(:voteable) { FactoryBot.build(:article) }

    context 'when user is nil (not logged in)' do
      it 'returns false' do
        expect(voteable).not_to be_upvoted_by_user(nil)
      end
    end

    context 'when voteable is not upvoted by user' do
      it 'returns false' do
        expect(voteable).not_to be_upvoted_by_user(user)
      end
    end

    context 'when voteable is upvoted by user' do
      before do
        FactoryBot.create(:vote, user: user, voteable: voteable)
      end

      it 'returns true' do
        expect(voteable).to be_upvoted_by_user(user)
      end
    end
  end
end
