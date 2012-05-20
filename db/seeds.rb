# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  Hunt.destroy_all
  Task.destroy_all
  HuntTask.destroy_all
  User.destroy_all


  # make_hunts
    #city_hunt = Hunt.create name: 'Scour the City'
    hood_hunt = Hunt.create name: 'Best of Ukranian Villiage'


    open("db/hood_hunt.txt") do |tasks|
      tasks.read.each_line do |row|
        name, location, points = row.chomp.split("|")
        hood_hunt.tasks.create!(:name => name, :location => location, :points => points)
      end
    end

  # make_users
    admin = User.create!(:name => "Ben",
                         :email => "Ben@mychi.com",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    20.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

  puts "Rails dev db ready for use"
end
