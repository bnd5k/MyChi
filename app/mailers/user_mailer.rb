class UserMailer < ActionMailer::Base

  default :from => "TryMyChi@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    attachments["rails.png"] = File.read("#{Rails.root}/app/assets/images/rails.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
<<<<<<< HEAD
  
  def invitation(invitation)
    invitation.update_attribute(:sent_at, Time.now)
    mail(:to => invitation.recipient_email, :subject => "You're invited", :body => "Welcome")
  end
        
=======
>>>>>>> add-bootstrap
end
