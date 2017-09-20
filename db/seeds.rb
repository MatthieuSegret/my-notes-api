# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Comment.destroy_all
Note.destroy_all

user = User.create(name: Faker::GameOfThrones.character)
10.times do
  note = Note.create(title: Faker::Book.title, content: Faker::Lorem.sentence, user: user)
  rand(0..2).times do
    note.comments.create(body: Faker::Lorem.sentence)
  end
end
