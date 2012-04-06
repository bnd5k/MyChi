class HuntsController < ApplicationController
  # GET /hunts
  # GET /hunts.json
  def index
    @hunts = Hunt.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hunts }
    end
  end

  # GET /hunts/1
  # GET /hunts/1.json
  def show
    @hunt = Hunt.find(params[:id])
<<<<<<< HEAD
    @title = @hunt.name 
    @tasks = @hunt.hunt_tasks.paginate(:page => params[:page])
=======

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hunt }
    end
>>>>>>> 02795a9799047990236848b6d3e3efbfeeb1b01b
  end

  # GET /hunts/new
  # GET /hunts/new.json
  def new
<<<<<<< HEAD
    if current_user?(nil) then    
      redirect_to signin_path
    else
      @hunt = Hunt.new
      @title = "New Hunt"    
      3.times do 
       task = @hunt.hunt_tasks.build
                  
      end
    end
  end
  
=======
    @hunt = Hunt.new
    3.times do |i|
        t = @hunt.hunt_tasks.build
        #t.name = "task-#{i}"
    end
>>>>>>> 02795a9799047990236848b6d3e3efbfeeb1b01b

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hunt }
    end
  end

  # GET /hunts/1/edit
  def edit
    @hunt = Hunt.find(params[:id])
  end

  # POST /hunts
  # POST /hunts.json
  def create
    @hunt = Hunt.new(params[:hunt])

    respond_to do |format|
      if @hunt.save
        format.html { redirect_to @hunt, notice: 'Hunt was successfully created.' }
        format.json { render json: @hunt, status: :created, location: @hunt }
      else
        format.html { render action: "new" }
        format.json { render json: @hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hunts/1
  # PUT /hunts/1.json
  def update
    @hunt = Hunt.find(params[:id])

    respond_to do |format|
      if @hunt.update_attributes(params[:hunt])
        format.html { redirect_to @hunt, notice: 'Hunt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hunts/1
  # DELETE /hunts/1.json
  def destroy
    @hunt = Hunt.find(params[:id])
    @hunt.destroy

    respond_to do |format|
      format.html { redirect_to hunts_url }
      format.json { head :no_content }
    end
  end
end
