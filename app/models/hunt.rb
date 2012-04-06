class Hunt < ActiveRecord::Base

<<<<<<< HEAD
  has_many :hunt_tasks  
  has_many :tasks, :through => :hunt_tasks
  accepts_nested_attributes_for :tasks

=======
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


>>>>>>> 02795a9799047990236848b6d3e3efbfeeb1b01b
  attr_accessible :name
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 } ,
                    :uniqueness => { :case_sensitive => false }

##, :foreign_key => :hunt_id
#  has_many :hunt_tasks
 # has_many :tasks, :through => :hunt_tasks
  #accepts_nested_attributes_for :hunt_tasks, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  #has_many :tasks, :through => :hunt_tasks, :foreign_key => :task_id
  #accepts_nested_attributes_for :tasks
  #accepts_nested_attributes_for :hunt_tasks


#  has_many :tasks, :through => :hunt_tasks #, :foreign_key => :hunt_id


#  accepts_nested_attributes_for :hunt_tasks
 # accepts_nested_attributes_for :tasks, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
    
  #has_many :tasks
  #accepts_nested_attributes_for :tasks


end
