# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Editor.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Slideshow.create!()

i = 0
100.times do

  i += 1
  Post.create!(title: "Post#{i}", by_line: 'Me', blurb: 'HEYA this is a blurb about a really cool article, but I bet you didnt know that!', slug: "post#{i}", published: true)

end