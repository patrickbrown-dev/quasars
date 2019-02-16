module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable, dependent: :destroy

    # TODO: This is a wildly insufficient algorithm to capture
    # the "hotness" of a given article, but created_at :desc is
    # the best user experience for now.
    scope :hot, (lambda do
      includes(:user)
        .includes(:votes)
        .includes(:comments)
        .order(created_at: :desc)
    end)
  end

  def upvoted_by_user?(user)
    # This is hacky solution improve database performance (avoids
    # a lookup for each voteable that tests this). This method is
    # only ever used where "user" is the current user, so the call
    # on user.votes will be cached each consecutive time it is
    # called.
    return false if user.nil?

    !(votes.map(&:id) & user.votes.map(&:id)).empty?
  end
end
