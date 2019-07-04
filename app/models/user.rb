class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :name_read, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :research, presence: true
  
  has_secure_password

  has_many :mains, dependent: :destroy

  has_many :presents, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :checks, dependent: :destroy
  has_many :check_comments, through: :checks, source: :comment

  def check(comment)
    self.checks.find_or_create_by(comment_id: comment.id)
  end

  def uncheck(comment)
    check = self.checks.find_by(comment_id: comment.id)
    check.destroy if check
  end

  def check?(comment)
    self.check_comments.include?(comment)
  end
end
