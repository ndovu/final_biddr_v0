FactoryGirl.define do
  factory :auction do
    association :user, factory: :user
    title Faker::Commerce.product_name
    description Faker::Lorem.paragraph
    reserve_price 60
    ends_on DateTime.now + 33.days
  end
end