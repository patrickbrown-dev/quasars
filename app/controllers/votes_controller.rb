class VotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_voteable, only: [:create, :destroy]

  def create
    @voteable.karma += 1
    @vote = Vote.new(voteable: @voteable)
    @vote.user = current_user

    unless Vote.exists?(user: current_user, voteable: @voteable)
      @vote.transaction do
        @vote.save!
        @voteable.save!
      end
    end

    render plain: 'ok'
  end

  def destroy
    @voteable.karma -= 1
    @vote = Vote.where(voteable: @voteable, user_id: current_user.id).first

    if @vote.present?
      @vote.transaction do
        @vote.destroy!
        @voteable.save!
      end
    end

    render plain: 'ok'
  end

  private

  def set_voteable
    return unless vote_params[:voteable_type].in?(['Article', 'Comment'])

    klass = vote_params[:voteable_type].constantize
    @voteable = klass.find(vote_params[:voteable_id])
  end

  def vote_params
    params.permit(:voteable_id, :voteable_type)
  end
end
