module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable, dependent: :destroy

    scope :hot, -> { order(karma: :desc).order(created_at: :desc) }
  end

  def upvoted_by_user?(user)
    votes.where(user: user).any?
  end
end
