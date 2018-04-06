class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :user_consistency_check, only: [:edit, :update, :destroy]

  def index
    page = params[:page] || 1
    @articles = Article.order(created_at: :desc).page(page).per(20)
  end

  def show
    @comment = Comment.new(user_id: current_user.try(:id), article_id: @article.id)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to "/", notice: 'Article was successfully destroyed.'
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:user_id, :title, :url, :description, :page)
  end

  def user_consistency_check
    if current_user != @article.user
      flash.alert = "You're not authorized to perform that action."
      redirect_to @article
    end
  end
end
