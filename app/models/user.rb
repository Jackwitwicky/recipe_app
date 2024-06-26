class User < ApplicationRecord
  attr_accessor :remember_token

  before_save {self.email = email.downcase}

  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
      uniqueness: {case_sensitive: false},
      format: { with: VALID_EMAIL_REGEX }

  #returns a hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #returns a random string
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #returns true if token matches digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password(remember_digest).is_password?(remember_token)
  end

  #forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end
  has_secure_password
end
