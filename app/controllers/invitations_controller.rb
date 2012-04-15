class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    p current_user
    @invitation.sender = current_user
    if @invitation.save
      if signed_in?
        p "before"
          p current_user
        UserMailer.invitation(@invitation).deliver
                p "after"

            p current_user

        flash[:notice] = "Thank you, invitation sent."
            p current_user
            
        redirect_to hunts_path      
      else
        flash[:notice] = "Thank you, we will notify when we are ready."
        redirect_to root_path  
      end
    else
      render :action => 'new'
    end
  end
  
end

