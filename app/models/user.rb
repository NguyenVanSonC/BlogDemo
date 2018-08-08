class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: Settings.maxname}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.maxemail},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.minlength_pw},
    allow_nil: true
  scope :recent, ->{order "users.name DESC"}
end
