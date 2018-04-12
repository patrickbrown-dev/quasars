class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :user, :title, :url, presence: true
  validates :url, uniqueness: true

  def upvoted_by_user?(user)
    votes.where(user: user).any?
  end

  scope :hot, -> {
    Article.order(karma: :desc).order(created_at: :desc)
  }
end
