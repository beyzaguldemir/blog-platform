class User < ApplicationRecord
  has_secure_password
  
  has_many :posts, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: %w[admin user] }
  
  before_validation :set_default_role
  
  private
  
  def set_default_role
    self.role ||= 'user'
  end
end
