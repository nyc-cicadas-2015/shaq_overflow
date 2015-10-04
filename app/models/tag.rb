class Tag < ActiveRecord::Base
  has_many :question_tags
  has_many :questions, through: :question_tags

  def self.make_tags(tags, question)
    tag_array = tags.split(" ")
    tag_array.each do |tag|
      question.tags.create(name: tag)
    end
  end
end


# tags = tag_params[:name]
# thetags = tags.split(" ")
# thetags.each do |tt|
# 	question.tags.create(name: tt)
# end