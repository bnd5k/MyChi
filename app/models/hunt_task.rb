class HuntTask < ActiveRecord::Base

  belongs_to :hunt
  belongs_to :task

end
