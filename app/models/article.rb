class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not a URL") unless is_url?(value) || value.empty?
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
  has_many :votes, as: :voteable, dependent: :destroy

  validates :user, :title, presence: true
  validates :url, :uid, uniqueness: true
  validates :url, url: true

  validate :url_and_or_description

  before_create :set_uid

  scope :hot, -> { Article.order(karma: :desc).order(created_at: :desc) }

  def upvoted_by_user?(user)
    votes.where(user: user).any?
  end

  def host
    uri = URI.parse(url)
    uri.host
  end

  def description_only?
    url.empty?
  end

  private
  def set_uid
    self.uid = "#{SecureRandom.hex(3)}-#{title.gsub(/[^0-9a-z ]/i, '').gsub(/\W/, '_').downcase}"
  end

  def url_and_or_description
    if url.empty? && description.empty?
      errors.add(:base, "Url and Description cannot both be empty")
    end
  end
end
