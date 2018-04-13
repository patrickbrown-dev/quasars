require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @article = articles(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { description: @article.description, title: "#{@article.title}2", url: "#{@article.url}2", user_id: @article.user_id } }
    end

    assert_redirected_to article_url(Article.last.uid)
  end

  test "should show article" do
    get article_url(@article.uid)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article.uid)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article.uid), params: { article: { description: @article.description, title: @article.title, url: @article.url } }
    assert_redirected_to article_url(@article.uid)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article.uid)
    end

    assert_redirected_to "/"
  end
end
