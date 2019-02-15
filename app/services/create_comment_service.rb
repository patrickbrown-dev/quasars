class CreateCommentService < ApplicationService
  def run(comment)
    comment.karma = 1

    user_replied_to = comment.parent_comment_or_article.user

    if comment.save
      Vote.create!(user: comment.user, voteable: comment)

      if should_email?(comment.user, user_replied_to)
        CommentMailer
          .with(comment: comment, user: user_replied_to)
          .comment_email.deliver_later
      end

      Optional.some(comment)
    else
      Optional.none
    end
  end

  private

  def should_email?(comment_user, user_replied_to)
    user_replied_to.email_notifications &&
      comment_user != user_replied_to
  end
end
