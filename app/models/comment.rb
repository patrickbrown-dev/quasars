class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  has_many :votes, as: :voteable, dependent: :destroy
  has_many   :comments, class_name: 'Comment', foreign_key: :parent_comment_id, dependent: :destroy

  scope :hot, -> { Comment.order(karma: :desc).order(created_at: :desc) }

  def upvoted_by_user?(user)
    votes.where(user: user).any?
  end
end
