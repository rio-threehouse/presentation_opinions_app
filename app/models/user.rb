class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }, confirmation: true
  validates :name_confirmation, presence: true
  validates :research, presence: true
  
  has_secure_password

  has_many :mains, dependent: :destroy
end
