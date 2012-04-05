class HuntTask < ActiveRecord::Base
  #accepts_nested_attributes_for :hunts
  belongs_to :hunts
  has_many :tasks, :through => :hunt_tasks
   # the id for the association is in this table
  #belongs_to :tasks
 # attr_accessible :name
end
