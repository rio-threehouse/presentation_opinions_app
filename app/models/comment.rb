class Comment < ApplicationRecord
  belongs_to :present
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 100 }
  validates :tag, presence: true
end
