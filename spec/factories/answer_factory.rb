FactoryGirl.define do

  factory :answer do
    body { Faker::Lorem.word }
    user
    question
  end

end