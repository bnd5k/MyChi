class Hunt < ActiveRecord::Base

  has_and_belongs_to_many :tasks
  attr_accessible :name
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 } ,
                    :uniqueness => { :case_sensitive => false }

end
