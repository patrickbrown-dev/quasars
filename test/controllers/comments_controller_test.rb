require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @comment = comments(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { article_id: @comment.article_id, body: @comment.body, user_id: @comment.user_id } }
    end

    assert_redirected_to article_path(Comment.last.article.uid)
  end

  test "should get edit" do
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { comment: { article_id: @comment.article_id, body: @comment.body, user_id: @comment.user_id } }

    assert_redirected_to article_path(@comment.article.uid)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to article_path(@comment.article.uid)
  end
end
