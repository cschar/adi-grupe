# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all


u = User.new(
            :email=>'c3@c.com',
            :password=>'horahora',
            :password_confirmation=>'horahora'
)
u.save

u2 = User.new(
    :email=>'d@d.com',
    :password=>'horahora',
    :password_confirmation=>'horahora'
)
u2.save

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Transaction.destroy_all
# require 'csv'
# CSV.foreach("db/Sacramentorealestatetransactions.csv", headers: true) do |line|
#   Transaction.create! line.to_hash.except(*%w{type latitude longitude})
# end