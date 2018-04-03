class Article < ApplicationRecord
  belongs_to :user

  validates :user, :title, :url, presence: true
  validates :url, uniqueness: true
end
