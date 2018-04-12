class VotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @article = Article.find(vote_params[:article_id])
    @article.karma += 1
    @vote = Vote.new(article_id: @article.id)
    @vote.user = current_user

    @vote.transaction do
      @vote.save!
      @article.save!
    end
    render plain: 'ok'
  end

  def destroy
    @article = Article.find(vote_params[:article_id])
    @article.karma -= 1
    @vote = Vote.where(article_id: @article.id, user_id: current_user.id).first

    @vote.transaction do
      @vote.destroy!
      @article.save!
    end
    render plain: 'ok'
  end

  private
  def vote_params
    params.permit(:article_id)
  end
end
