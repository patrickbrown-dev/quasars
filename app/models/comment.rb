class Comment < ApplicationRecord
  include Voteable

  belongs_to :article
  belongs_to :user

  validates :body, presence: true

  has_many :comments,
           class_name: 'Comment',
           foreign_key: :parent_comment_id,
           dependent: :destroy

  def parent_comment_or_article
    Comment.find_by(id: parent_comment_id) || article
  end
end
