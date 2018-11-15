class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :comments

  validates :username, presence: true, uniqueness: true

  def karma
    total = 0
    total += articles.map(&:karma).reduce(:+) || 0
    total += comments.map(&:karma).reduce(:+) || 0
    total
  end
end
