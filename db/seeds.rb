# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Link.delete_all

p "******************"
p "SEEDING IN PROGRESS"

file_data = File.read("link.txt").split

file_data.each do |data|
    p '.'
    link = Link.create(
        url: data,
        clicked: rand(1..1000)
     )


    ScraperJob.perform_now(link.id)

end

puts ""
p "SEEDING COMPLETE"
p "******************"