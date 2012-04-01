class HuntTask < ActiveRecord::Bas   
  belongs_to :hunt # the id for the association is in this table
  belongs_to :task
end
