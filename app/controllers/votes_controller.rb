class VotesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.save

    render plain: 'ok'
  end

  private
  def vote_params
    params.require(:vote).permit(:article_id)
  end
end
