FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Internet.password(12)
    sequence(:email) {|n| 'factory_girl_email_test_#{n}@gmail.com' }
  end
end
