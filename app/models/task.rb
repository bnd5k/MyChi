class Task < ActiveRecord::Base
  
 # has_many :hunt_tasks
 # has_many :hunts, :through => :hunt_tasks
 
 
 
  # has_many :hunt_tasks
 # has_many :hunts, :through => :hunt_tasks#, :foreign_key => :hunt_id

#  has_many :hunts

  belongs_to :hunts
  attr_accessible :name 
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 } ,
                    :uniqueness => { :case_sensitive => false }

end
