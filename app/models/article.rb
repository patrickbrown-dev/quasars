class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not a URL") unless is_url?(value)
  end

  private
  def is_url?(value)
    uri = URI.parse(value)
    %w(http https).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end

class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :user, :title, :url, presence: true
  validates :url, :uid, uniqueness: true
  validates :url, url: true

  before_create :set_uid

  scope :hot, -> { Article.order(created_at: :desc).order(karma: :desc) }

  def upvoted_by_user?(user)
    votes.where(user: user).any?
  end

  def host
    uri = URI.parse(url)
    uri.host
  end

  private
  def set_uid
    self.uid = "#{SecureRandom.hex(3)}-#{title.gsub(/[^0-9a-z ]/i, '').gsub(/\W/, '_').downcase}"
  end
end
