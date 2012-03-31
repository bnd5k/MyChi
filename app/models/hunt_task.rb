    class HuntTask < ActiveRecord::Base
      attr_accessible :name
       
      belongs_to :hunt # the id for the association is in this table
      belongs_to :task
    end
