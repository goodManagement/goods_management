# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# user_names = {"pokotsun" => true, "abetaku" => true, "nomy" => true,
#   "yamako" => false, "koniatsu" => false}

user = User.new(
  :username => "pokotsun",
  :is_admin => true,
  :email => "",
  :password => "aiueok")
  user.save!

user = User.new(
  :username => "tAkuMiNL",
  :is_admin => true,
  :email => "",
  :password => "abcde")
  user.save!
)

  # user_names.each do |name, val|
  #   user = User.new(
  #     :username => name,
  #     :is_admin => val,
  #     :email => "",
  #     :password => "abcdef")
  #   user.save!
