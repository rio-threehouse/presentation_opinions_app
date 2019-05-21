class Main < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :date, presence: true
  validates :time, presence: true, length: {maximum: 10 }
  validates :group, presence: true
end
