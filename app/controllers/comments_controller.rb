class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :user_consistency_check, only: [:edit, :update, :destroy]

  def edit; end

  def create
    @comment = Comment.new(comment_params)
    create_comment_service = CreateCommentService.new
    comment_optional = create_comment_service.run(@comment)

    if comment_optional.none?
      redirect_to(
        article_path(@comment.article.uid),
        alert: 'Comments cannot be blank'
      )
    else
      @comment = comment_optional.get
      redirect_to(
        article_path(@comment.article.uid),
        notice: 'Comment was successfully created.'
      )
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to(
        article_path(@comment.article.uid),
        notice: 'Comment was successfully updated.'
      )
    else
      render :edit
    end
  end

  def destroy
    article = @comment.article
    @comment.destroy

    redirect_to(
      article_path(article.uid),
      notice: 'Comment was successfully destroyed.'
    )
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :article_id,
      :user_id,
      :body,
      :parent_comment_id
    )
  end

  def user_consistency_check
    return if current_user.moderator || current_user == @comment.user

    head :forbidden
  end
end
