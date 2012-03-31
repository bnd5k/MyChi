class Hunt < ActiveRecord::Base

  has_and_belongs_to_many :tasks
  accepts_nested_attributes_for :tasks, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  attr_accessible :name
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 } ,
                    :uniqueness => { :case_sensitive => false }

end
