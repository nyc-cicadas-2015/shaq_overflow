class Response < ActiveRecord::Base
  has_many :votes, as: :votable
  belongs_to :respondable, polymorphic: true
  belongs_to :user

  validates :body, presence: true
  
end
