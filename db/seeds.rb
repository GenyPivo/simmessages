# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.new
u.email = 'admin@test.com'
u.password = 111111
u.password_confirmation = 111111
u.admin = true
u.save!

(1..50).each do |i|
  u = User.new
  u.email = "user#{i}@test.com"
  u.password = 111111
  u.password_confirmation = 111111
  u.save!
end
