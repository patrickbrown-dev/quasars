class UserPresenter < ApplicationPresenter
  delegate :active_for_authentication?, :articles, :comments, :karma, to: :model

  def username
    return 'deleted' unless active_for_authentication?

    @model.username
  end

  def status
    return 'User account deactivated' unless active_for_authentication?

    'Active user'
  end

  def priviledges
    return 'Moderator' if @model.moderator

    'User'
  end
end
