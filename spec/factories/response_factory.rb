FactoryGirl.define do

  factory :response do
    body { Faker::Lorem.paragraph }
    user
  end

end