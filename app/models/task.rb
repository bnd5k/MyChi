class Task < ActiveRecord::Base
  
  has_many :hunt_tasks
  has_many :hunts, :through => :hunt_tasks
  attr_accessible :name
 
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 } ,
                    :uniqueness => { :case_sensitive => false }

end
