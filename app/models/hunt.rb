class Hunt < ActiveRecord::Base

  has_many :hunt_tasks  
  has_many :tasks, :through => :hunt_tasks
  accepts_nested_attributes_for :tasks

end