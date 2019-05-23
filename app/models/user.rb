class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :name_read, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :research, presence: true
  
  has_secure_password

  has_many :mains, dependent: :destroy

  has_many :presents, dependent: :destroy
end
