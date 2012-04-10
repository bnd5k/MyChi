class HuntsController < ApplicationController

  def index
    p current_user
     @title = "All Hunts"
     @hunts = Hunt.paginate(:page => params[:page])
  end

  def show
    @hunt = Hunt.find(params[:id])
    @title = @hunt.name 
    @tasks = @hunt.tasks.paginate(:page => params[:page])
  end

  def new
    if current_user?(nil) then    
      redirect_to signin_path
    else
      @hunt = Hunt.new
      @title = "New Hunt"
      3.times { @hunt.tasks.build }
    end
  end
  

  def create
    @hunt = Hunt.new(params[:hunt])
    if @hunt.save
      flash[:success] = "Hunt created!"
      redirect_to hunts_path
    else
      @title = "New Hunt"
      render 'new'     
    end
  end

  def edit
    if current_user?(nil) then
       redirect_to hunts_path 
    else
      if current_user.admin? then
        @hunt = Hunt.find(params[:id])
        @title = "Edit hunt"
      else
        redirect_to hunts_path 
      end
    end
  end

  def update
    @hunt = Hunt.find(params[:id])
    if @hunt.update_attributes(params[:hunt])   
      redirect_to hunt_path(@hunt) #hunts_path
      flash[:success] = "Hunt updated."
    else
      @title = "Edit Hunt"
      render 'edit'
    end
  end
  
  def destroy
    Hunt.find(params[:id]).destroy
    flash[:success] = "Hunt destroyed."
    redirect_to hunts_path
  end
  
end

