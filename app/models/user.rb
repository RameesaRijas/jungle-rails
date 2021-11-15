class User < ActiveRecord::Base
  
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    if email && password
      @user = self.where("lower(email) = ?", email.delete(' ').downcase).first.try(:authenticate, password)
    end
  end
end