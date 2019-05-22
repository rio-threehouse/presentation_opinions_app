class Present < ApplicationRecord
  belongs_to :user
  belongs_to :main

  validates :title, presence: true, length: { maximum: 50 }
  validates :research, presence: true
end
