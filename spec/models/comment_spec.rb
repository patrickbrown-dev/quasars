require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.build(:user) }
  let(:article) { FactoryBot.build(:article) }

  it 'returns valid for fully formed comments' do
    comment = Comment.new(user: user, article: article, body: 'hey!')
    expect(comment).to be_valid
  end

  it "validates that comments can't be blank" do
    comment = Comment.new(user: user, article: article)
    expect(comment).not_to be_valid
  end
end
