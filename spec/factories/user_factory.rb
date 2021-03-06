FactoryGirl.define do
  factory :user do
    username  Faker::Internet.user_name
    name  Faker::Name.name
    password  Faker::Internet.password
  end
  factory :new_user, class: User do
  	username  { Faker::Internet.user_name }
    name  { Faker::Name.name }
    password  { Faker::Internet.password }
  end
end