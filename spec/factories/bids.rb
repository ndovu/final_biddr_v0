FactoryGirl.define do
  factory :bid do
    association :user, factory: :user
    association :auction, factory: :auction
    amount 100
  end
end