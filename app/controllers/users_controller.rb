class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:current]

  def index
    page = params[:page] || 1
    @users = User.all.page(page).per(20)
  end

  def show
    @user = User.find_by!(username: params[:username])
  end
end
