class VotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @vote = Vote.new(article_id: vote_params[:article_id])
    @vote.user = current_user

    @vote.save!
    render plain: 'ok'
  end

  def destroy
    @vote = Vote.where(article_id: vote_params[:article_id], user_id: current_user.id).first
    @vote.destroy!
    render plain: 'ok'
  end

  private
  def vote_params
    params.permit(:article_id)
  end
end
