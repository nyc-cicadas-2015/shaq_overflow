class Tag < ActiveRecord::Base
  has_many :question_tags
  has_many :questions, through: :question_tags

  def self.make_tags(tags, question)
    tag_array = tags.split
    tag_array.each do |tag|
    	# check if tag already exists
      question.tags.create(tag: tag)
    end
  end

end