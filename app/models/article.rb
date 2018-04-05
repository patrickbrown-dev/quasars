class Article < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :user, :title, :url, presence: true
  validates :url, uniqueness: true
end
