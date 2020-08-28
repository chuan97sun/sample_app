class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_create :create_activation_digest
  before_save :downcase_email

  USERS_PARAMS = %i(name email password password_confirmation).freeze

  validates :name, presence: true, 
    length: { maximum: Settings.source.collection.names_max }
   

  validates :email, presence: true, 
    length: { maximum: Settings.source.collection.email_max },
    format: { with: Settings.source.collection.email_valid_regex },
    uniqueness: true

  validates :password, presence: true, 
    length: { minimum: Settings.source.collection.password_min }

  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
  
  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
