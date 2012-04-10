class UserMailer < ActionMailer::Base

  default :from => "TryMyChi@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    attachments["rails.png"] = File.read("#{Rails.root}/app/assets/images/rails.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
  
  def invitation(invitation)

 #   url_path = invitation_url(invitation.token)
#    subject    'Invitation'
 #   recipients invitation.recipient_email
    #body       :invitation => invitation, :signup_url => url_path
    body "You have been invited"
    invitation.update_attribute(:sent_at, Time.now)

    
    mail(:to => invitation.recipient_email, :subject => "You're invited")

  end


end
