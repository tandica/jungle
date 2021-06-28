class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 7 }
  before_save   :downcase_email
  has_secure_password

  def self.authenticate_with_credentials(email, pass)
    user = User.find_by_email(email.downcase.strip)
    if user
      user.authenticate(pass)
    end
  end

  def downcase_email
    self.email = email.downcase
  end
end 
