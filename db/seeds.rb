# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'Karl', email: 'karlis@home.com', password: 'password', password_confirmation: 'password', api_key: "b347e854e17cfd30c23c75b1a54d6ed2428073cd9caf94b6")