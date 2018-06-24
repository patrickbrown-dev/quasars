require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe "#create" do
    let(:voteable) { FactoryBot.create(:article) }
    let(:user) { FactoryBot.create(:user) }

    context "while logged in" do
      before { sign_in user }

      it "increments karma" do
        post :create, params: {
               voteable_id: voteable.id,
               voteable_type: voteable.class.to_s
             }

        voteable.reload
        expect(voteable.karma).to eq(2)
      end

      it "creates a vote record" do
        post :create, params: {
               voteable_id: voteable.id,
               voteable_type: voteable.class.to_s
             }

        vote = Vote.find_by(
          user: user,
          voteable_id: voteable.id,
          voteable_type: voteable.class.to_s
        )

        expect(vote).not_to be_nil
      end

      it "will not increment more than once" do
        post :create, params: {
               voteable_id: voteable.id,
               voteable_type: voteable.class.to_s
             }

        expect {
          post :create, params: {
                 voteable_id: voteable.id,
                 voteable_type: voteable.class.to_s
               }
        }.to raise_error(ActiveRecord::RecordInvalid)

        voteable.reload
        expect(voteable.karma).to eq(2)
      end
    end
  end
end
