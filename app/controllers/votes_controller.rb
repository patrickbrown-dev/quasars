class VotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_voteable, only: [:create, :destroy]

  def create
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
    @voteable.karma -= 1
    @vote = Vote.where(voteable: @voteable, user_id: current_user.id).first

    @vote.transaction do
      @vote.destroy!
      @voteable.save!
    end
    render plain: 'ok'
  end

  private

  def set_voteable
    @voteable = if vote_params[:voteable_type] == 'Article'
                  Article.find(vote_params[:voteable_id])
                else
                  Comment.find(vote_params[:voteable_id])
                end
  end

  def vote_params
    params.permit(:voteable_id, :voteable_type)
  end
end
