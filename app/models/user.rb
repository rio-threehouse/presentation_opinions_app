class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }, confirmation: true
  validates :name_confirmation, presence: true
end
