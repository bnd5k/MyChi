class HuntTask < ActiveRecord::Base
<<<<<<< HEAD
  belongs_to :hunts
  belongs_to :tasks

=======
  #accepts_nested_attributes_for :hunts
  belongs_to :hunts
  has_many :tasks, :through => :hunt_tasks
   # the id for the association is in this table
  #belongs_to :tasks
 # attr_accessible :name
>>>>>>> 02795a9799047990236848b6d3e3efbfeeb1b01b
end
