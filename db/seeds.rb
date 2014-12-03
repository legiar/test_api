# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p1 = Product.find_or_create_by!(title: "Halo 4")
p1.bonus_codes.find_or_create_by!(number: "123")
p1.bonus_codes.find_or_create_by!(number: "345", used: true)

p2 = Product.find_or_create_by!(title: "Samsung Galaxy 4",
  service: Service::TV.find_or_create_by!(name: "TV", status: true))
p2.bonus_codes.find_or_create_by!(number: "567")
p2.bonus_codes.find_or_create_by!(number: "789")

Product.find_or_create_by!(title: "Skype $10",
  service: Service::RTG.find_or_create_by!(name: "RTG", codes: true, status: true))
