FactoryGirl.define do

  factory :question do
    title { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    user
  end

end