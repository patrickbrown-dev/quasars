class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :user, :title, :url, :uid, presence: true
  validates :url, :uid, uniqueness: true

  before_save :set_uid

  scope :hot, -> { Article.order(created_at: :desc).order(karma: :desc) }

  def upvoted_by_user?(user)
    votes.where(user: user).any?
  end

  private
  def set_uid
    self.uid = "#{SecureRandom.hex(3)}-#{title.gsub(/[^0-9a-z ]/i, '').gsub(/\W/, '_').downcase}"
  end
end
