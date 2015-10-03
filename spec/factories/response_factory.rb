FactoryGirl.define do

  factory :response do
    body { Faker::Lorem.paragraph }
    user
    question
  end

end