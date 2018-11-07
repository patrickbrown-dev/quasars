class CreateCommentService < ApplicationService
  def run(comment)
    comment.karma = 1

    user_replied_to = comment.parent_comment_or_article.user

    if comment.save
      Vote.create!(user: comment.user, voteable: comment)

      unless comment.user == user_replied_to
        CommentMailer
          .with(comment: comment, user: user_replied_to)
          .comment_email.deliver_later
      end

      Optional.success(comment)
    else
      Optional.failure(comment, comment.errors.join(', '))
    end
  end
end
