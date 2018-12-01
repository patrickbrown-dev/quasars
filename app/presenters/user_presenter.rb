class UserPresenter < ApplicationPresenter
  attr_reader :user

  delegate :active_for_authentication?, to: :user

  def initialize(user)
    @user = user
  end

  def username
    return 'deleted' unless active_for_authentication?

    @user.username
  end
end
