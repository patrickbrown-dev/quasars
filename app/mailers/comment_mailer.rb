class CommentMailer < ApplicationMailer
  default from: 'notifications@quasa.rs'

  def comment_email
    @comment = params[:comment]
    @user = params[:user]
    mail(
      to: @user.email,
      subject: "#{@comment.user.username} replied to your post on quasars"
    )
  end
end
