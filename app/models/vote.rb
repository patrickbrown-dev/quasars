class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user, uniqueness: { scope: :article }
end
