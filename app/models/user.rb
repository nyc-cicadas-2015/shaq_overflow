class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :responses
  has_many :votes

  validates :name, presence: true
  validates :username, presence: true
  validates :password, presence: true

  has_secure_password
end
