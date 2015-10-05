class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :votable
  has_many :responses, as: :respondable

  validates :body, presence: true
end
