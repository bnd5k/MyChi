class Task < ActiveRecord::Base
<<<<<<< HEAD
 
  belongs_to :hunts 
=======
  
 # has_many :hunt_tasks
 # has_many :hunts, :through => :hunt_tasks
 
 
 
  # has_many :hunt_tasks
 # has_many :hunts, :through => :hunt_tasks#, :foreign_key => :hunt_id

#  has_many :hunts

  belongs_to :hunts
>>>>>>> 02795a9799047990236848b6d3e3efbfeeb1b01b
  attr_accessible :name 
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 } ,
                    :uniqueness => { :case_sensitive => false }
 

end
