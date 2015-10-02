FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name}
    name { Faker::Name.name }
    password_digest { Faker::Internet.password }
  end
end