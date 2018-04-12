class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:current]

  def current
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end
end
