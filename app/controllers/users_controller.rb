  class UsersController < ApplicationController
    before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
    before_filter :correct_user, :only => [:edit, :update]
    before_filter :admin_user,   :only => :destroy


  def index
    if current_user && current_user.admin?
     @title = "All users"
     @users = User.paginate(:page => params[:page])
    else
      redirect_to root_path
    end 
  end

  def show
    @user = User.find(params[:id])
    if current_user.id == @user.id or current_user.admin? 
     @title = @user.name
    else
  
      redirect_to root_path   
    end
  end
     
  def new
   if current_user?(nil)# = nil #.signed_in?
      @user = User.new(:invitation_token => params[:invitation_token])
      @user.email = @user.invitation.recipient_email if @user.invitation     
      @title = "Sign up"
 
    else
      flash[:error] = "Why sign up again?  You're already in!"
      redirect_to root_path 
    end  
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
      UserMailer.registration_confirmation(@user).deliver
    else
      @title = "Sign up"
      render 'new'
      
    end
  end

 
   def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  private

    def authenticate
      deny_access unless signed_in?
    end  
    
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end    
end
