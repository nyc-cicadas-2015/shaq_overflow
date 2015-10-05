class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :responses
  has_many :votes

  validates :name, presence: true, uniqueness: true
  validates :username, presence: true
  validates :email, presence: true

  has_secure_password
end
