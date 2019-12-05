class Comment < ApplicationRecord
  belongs_to :present
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 225 }
  validates :tag, presence: true

  has_many :checks, dependent: :destroy
end
