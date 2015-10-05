class Tag < ActiveRecord::Base
  has_many :question_tags
  has_many :questions, through: :question_tags

  validates :name, presence: true

  def self.make_tags(tags, question)
    tag_array = tags.split(" ")
    tag_array.each do |new_tag|
    	existing_tag = Tag.find_by(name: new_tag)
    	if existing_tag
    		question.tags.push(existing_tag)
    	else
      	question.tags.create(name: new_tag)
      end
  	end
  end
end