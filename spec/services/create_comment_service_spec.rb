require 'rails_helper'

RSpec.describe CreateCommentService, type: :service do
  describe '#run' do
    subject(:service) { CreateCommentService.new }

    let(:comment) { FactoryBot.build(:comment) }

    before do
      allow(CommentMailer).to receive(:with).and_return(CommentMailer)
    end

    it 'creates a vote object' do
      service.run(comment)

      vote = Vote.find_by(voteable: comment, voteable_type: comment.class.to_s)

      expect(vote).not_to be_nil
    end

    it 'sets the comment karma to 1' do
      service.run(comment)

      expect(comment.reload.karma).to eq(1)
    end

    context 'when user is replying to their own article/comment' do
      let(:user) { FactoryBot.build(:user) }
      let(:article) { FactoryBot.build(:article, user: user) }
      let(:comment) { FactoryBot.build(:comment, user: user, article: article) }

      it 'does not send an email' do
        service.run(comment)

        expect(CommentMailer)
          .not_to have_received(:with)
      end
    end

    context 'when replying to an article' do
      let(:article) { FactoryBot.build(:article) }
      let(:comment) { FactoryBot.build(:comment, article: article) }

      it 'sends an email to the article poster' do
        service.run(comment)

        expect(CommentMailer)
          .to have_received(:with)
                .with(comment: comment, user: article.user)
      end
    end

    context 'when replying to a comment' do
      let(:article) { FactoryBot.build(:article) }
      let(:parent_comment) { FactoryBot.create(:comment, article: article) }
      let(:comment) do
        FactoryBot.build(:comment,
                         article: article,
                         parent_comment_id: parent_comment.id)
      end

      it 'sends an email to the parent comment user' do
        service.run(comment)

        expect(CommentMailer)
          .to have_received(:with)
                .with(comment: comment, user: parent_comment.user)
      end
    end
  end
end
