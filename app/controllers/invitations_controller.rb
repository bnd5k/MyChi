class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      if signed_in?
        UserMailer.invitation(@invitation).deliver
        flash[:notice] = "Thank you, invitation sent."
        redirect_to hunts_path      
      else
        flash[:notice] = "Sign in and we'll get things started."
        redirect_to signin_path  
      end
    else
      render :action => 'new'
    end
  end
  
end

