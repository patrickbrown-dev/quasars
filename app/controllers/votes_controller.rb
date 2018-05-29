class VotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @voteable = if vote_params[:voteable_type] == 'Article'
                  Article.find(vote_params[:voteable_id])
                else
                  Comment.find(vote_params[:voteable_id])
                end
    @voteable.karma += 1
    @vote = Vote.new(voteable: @voteable)
    @vote.user = current_user

    @vote.transaction do
      @vote.save!
      @voteable.save!
    end
    render plain: 'ok'
  end

  def destroy
    @voteable = if vote_params[:voteable_type] == 'Article'
                  Article.find(vote_params[:voteable_id])
                else
                  Comment.find(vote_params[:voteable_id])
                end
    @voteable.karma -= 1
    @vote = Vote.where(voteable: @voteable, user_id: current_user.id).first

    @vote.transaction do
      @vote.destroy!
      @voteable.save!
    end
    render plain: 'ok'
  end

  private
  def vote_params
    params.permit(:voteable_id, :voteable_type)
  end
end
