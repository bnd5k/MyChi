class Invitation < ActiveRecord::Base

  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
      
<<<<<<< HEAD

end 
=======
      belongs_to :sender, :class_name => 'User'
      belongs_to :recipient, :class_name => 'User'
    
    end
>>>>>>> add-bootstrap
