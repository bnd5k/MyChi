class TasksController < ApplicationController

  def index
     @title = "All Tasks"
     @tasks = Task.paginate(:page => params[:page])
  end

  def show
    @task = Task.find(params[:id])
    @title = @task.name    
  end

  def new
    if current_user?(nil) then    
      redirect_to signin_path
    else
      @task = Task.new
      @title = "New Task"  
    end
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:success] = "Task created!"
      redirect_to tasks_path
    else
      @title = "New Task"
      render 'new'     
    end
  end

  
  def edit
    if current_user?(nil) then
       redirect_to tasks_path 
    else
      if current_user.admin? then
        @task = Task.find(params[:id])
        @title = "Edit task"
      else
        redirect_to tasks_path 
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])   
      redirect_to task_path(@task) 
      flash[:success] = "Task updated."
    else
      @title = "Edit Task"
      render 'edit'
    end
  end
  
  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Task destroyed."
    redirect_to tasks_path
  end
  
end

