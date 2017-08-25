# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do
  User.create(username: Faker::Internet.user_name,
              password_digest: BCrypt::Password.create('password')
  )
end

users = User.all.size

30.times do
  Cat.create(birth_date: Faker::Date.birthday(0, 15),
             color: %w(black grey orange calico white other).sample,
             name: Faker:: Name.first_name,
             sex: %w(M F).sample,
             user_id: rand(1..users),
             description: Faker::Lorem.words(rand(1..15)).join)
end

cats = Cat.all.size

50.times do
  CatRentalRequest.create(cat_id: rand(1..cats),
                          start_date: Faker::Date.backward(30),
                          end_date: Faker::Date.forward(30),
                          status: %w(PENDING APPROVED DENIED).sample)
end
