# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do
  user = User.create(first_name: Faker::Internet.user_name,
                              email: Faker::Internet.email)
  auction = Auction.create(title: Faker::Commerce.product_name, 
                            description: Faker::Lorem.paragraph,
                            reserve_price: Faker::Number.number(2),
                            ends_on: DateTime.now + Faker::Number.number(2).to_i.days,
                            user_id: user)
end