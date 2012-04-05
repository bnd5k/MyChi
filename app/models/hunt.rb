class Hunt < ActiveRecord::Base

#  has_many :hunt_tasks
 # has_many :tasks, :through => :hunt_tasks
  #accepts_nested_attributes_for :hunt_tasks, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  #has_many :tasks, :through => :hunt_tasks, :foreign_key => :task_id
  #accepts_nested_attributes_for :tasks
  #accepts_nested_attributes_for :hunt_tasks
  
  has_many :hunt_tasks  
  has_many :tasks, :through => :hunt_tasks, :foreign_key => :hunt_id

  accepts_nested_attributes_for :tasks

#  has_many :tasks, :through => :hunt_tasks #, :foreign_key => :hunt_id


#  accepts_nested_attributes_for :hunt_tasks
 # accepts_nested_attributes_for :tasks, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
    
  #has_many :tasks
  #accepts_nested_attributes_for :tasks


  attr_accessible :name
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 } ,
                    :uniqueness => { :case_sensitive => false }

end
