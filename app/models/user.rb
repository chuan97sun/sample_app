class User < ApplicationRecord
  USERS_PARAMS = %i(name email password password_confirmation).freeze
  
  before_save :downcase_email

  validates :name, presence: true, 
    length: { maximum: Settings.source.collection.names_max }
   

  validates :email, presence: true, 
    length: { maximum: Settings.source.collection.email_max },
    format: { with: Settings.source.collection.email_valid_regex },
    uniqueness: true

  validates :password, presence: true, 
    length: { minimum: Settings.source.collection.password_min }

  has_secure_password

  private
  
  def downcase_email
    email.downcase!
  end

  class << self
    def User.digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
