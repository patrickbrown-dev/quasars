require 'rails_helper'

RSpec.describe CommentMailer, type: :mailer do
  subject(:mail) do
    CommentMailer.with(comment: comment, user: user).comment_email
  end

  let(:comment) { FactoryBot.build(:comment) }
  let(:user) { FactoryBot.build(:user) }

  it 'sets the subject' do
    expect(mail.subject)
      .to eq("#{comment.user.username} replied to your post on quasars")
  end

  it 'sents the destination address' do
    expect(mail.to).to eq([user.email])
  end

  it 'sents the from address' do
    expect(mail.from).to eq(['notifications@quasa.rs'])
  end

  it 'renders the body' do
    expect(mail.body.encoded)
      .to match("#{comment.user.username} replied to your post on quasars")
  end

  it 'includes the body of the comment' do
    expect(mail.body.encoded).to match(comment.body)
  end

  it 'includes a link to the article' do
    expect(mail.body.encoded)
      .to match(article_url(comment.article.uid))
  end
end
