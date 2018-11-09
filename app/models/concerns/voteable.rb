module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable, dependent: :destroy

    # TODO: This is a wildly insufficient algorithm to capture
    # the "hotness" of a given article, but created_at :desc is
    # the best user experience for now.
    scope :hot, -> { order(created_at: :desc) }
  end

  def upvoted_by_user?(user)
    votes.where(user: user).any?
  end
end
