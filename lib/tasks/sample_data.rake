namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_hunts
    make_tasks
    make_hunt_tasks
  end
end   

def make_users
  admin = User.create!(:name => "Example User",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_hunts
  99.times do
    word = Faker::Lorem.words(1)
    puts word
    puts Hunt.create!(:name => word).name
    puts "#########"
  end
end

def make_tasks
  99.times do
    Task.create!(:name => Faker::Lorem.words(1), :points => 65)
  end

end

def make_hunt_tasks
  20.times do
    hunt = Hunt.all.sample
    HuntTask.create!(:hunt => hunt, :task => Task.all.sample)
  end
end
