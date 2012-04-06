class HuntTask < ActiveRecord::Base
  belongs_to :hunts
  belongs_to :tasks

end
