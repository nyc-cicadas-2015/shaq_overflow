class Question < ActiveRecord::Base
  has_many :votes, as: :votable
  has_many :answers
  has_many :question_tags
  has_many :tags, through: :question_tags
  belongs_to :user
  has_many :responses, as: :respondable

  def check_for_empty_fields?
    self.title == "" || self.body == ""
  end



end

