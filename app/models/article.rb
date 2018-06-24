class Article < ApplicationRecord
  include Voteable

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  validates :user, :title, presence: true
  validates :uid, uniqueness: true
  validates :url, uniqueness: true, allow_blank: true
  validates :url, url: true

  validate :url_and_or_description

  before_create :set_uid

  def host
    uri = URI.parse(url)
    uri.host
  end

  def description_only?
    url.empty?
  end

  private

  def set_uid
    hex = SecureRandom.hex(3)
    title_clean = title.gsub(/[^0-9a-z ]/i, '')
                    .gsub(/\W/, '_')
                    .downcase

    self.uid = "#{hex}-#{title_clean}"
  end

  def url_and_or_description
    return unless url.empty? && description.empty?
    errors.add(:base, 'Url and Description cannot both be empty')
  end
end
