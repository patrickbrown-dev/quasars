class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :user_consistency_check, only: [:edit, :update, :destroy]

  def edit; end

  def create
    @comment = Comment.new(comment_params)
    @comment.karma = 1

    if @comment.save
      Vote.create!(user: current_user, voteable: @comment)
      redirect_to(
        article_path(@comment.article.uid),
        notice: 'Comment was successfully created.'
      )
    else
      render :new
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

    flash.alert = "You're not authorized to perform that action."
    redirect_to article_path(@comment.article.uid)
  end
end
