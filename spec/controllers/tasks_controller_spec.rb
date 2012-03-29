require 'spec_helper'

describe TasksController do
  render_views
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    
    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "All Tasks")
    end

    it "should have an element for each task" do
      get :index
      Task.paginate(:page => 1).each do |task|
        response.should have_selector("li", :content => task.name)
      end
    end
      
    it "should paginate tasks" do
      get :index
      response.should have_selector('div.pagination')
      response.should have_selector('span.disabled', :content => "Previous")
      response.should have_selector('a', :href => "/tasks?page=2",
                                           :content => "2")
      response.should have_selector('a', :href => "/tasks?page=2",
                                           :content => "Next")
    end 
      
    describe "for signed in user who aren't admins" do
      
      before(:each) do
        @user = FactoryGirl.create(:user)
      end

      it "should not show edit option" do
        get 'index'
        Task.paginate(:page => 1).each do |task|              
          response.should_not have_selector('a', :href => edit_task_path(task), :content => 'edit')
        end
      end
    end
   
   describe "for admins" do
     before(:each) do
        admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end
          
     it "should show edit link" do
        get 'index'
        Task.paginate(:page => 1).each do |task|               
          response.should have_selector('a', :href => edit_task_path(task), :content => 'edit')
        end 
      end
            
      it "should show delete link" do
        get 'index'
        Task.paginate(:page => 1).each do |task|
          response.should have_selector('a', :href => task_path(task)   , :content => 'delete')
        end
      end

    end     
  end

  describe "GET 'show'" do
    before(:each) do
      @task = FactoryGirl.create(:task)
    end

    it "should be successful" do
      get :show, :id => @task
      response.should be_success
    end

    it "should find the right task" do
      get :show, :id => @task
      assigns(:task).should == @task
    end

    it "should have the right title" do
      get :show, :id => @task
      response.should have_selector("title", :content => @task.name)
    end

    it "should include the task's name" do
      get :show, :id => @task
      response.should have_selector("h1", :content => @task.name)
    end       

  end

  describe "GET 'new'" do
    describe "for non-admins" do
      it "should not return http success" do
        get 'new'
        response.should_not be_success
      end      
    end
    
    describe "for users who are admins" do
      before(:each) do
        admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end
    
      it "returns http success" do
        get 'new'
        response.should be_success
      end
  
      
      it "should have the right title" do
        get 'new'
        response.should have_selector("title", :content => "New Task")

      end
   
      it "should have a name field" do
        get 'new'
        response.should have_selector("input[name='task[name]'][type='text']")
      end   
    end    
  end

  describe "POST 'create'" do

    describe "failure" do
      before(:each) do
        @attr = { :name => "" }
      end

     it "should render the 'new' page" do
        post :create, :task => @attr
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, :task => @attr
        response.should have_selector("title", :content => "New Task")
      end

      it "should not create a task" do
        lambda do
          post :create, :task => @attr
        end.should_not change(Task, :count)
      end
    end
    
    describe "success" do
 
      before(:each) do
          @task = FactoryGirl.create(:task)
          @attr = { :name => "New Task" }
      end
  
      it "should create a task" do
        lambda do
          post :create, :task => @attr
        end.should change(Task, :count).by(1)  
      end
  
      it "should redirect to the tasks show page" do
        post :create, :task => @attr
        response.should redirect_to(tasks_path)
      end    
        
      it "should have a success message" do
        post :create, :task=> @attr
        flash[:success].should =~ /task created/i
      end               
    end
     
  end

  describe "GET 'edit'" do
    
    before(:each) do
       @task = FactoryGirl.create(:task)
    end
 
    describe "as a non-signed-in user" do
      it "should deny access" do
        get :edit, :id => @task
        response.should redirect_to(tasks_path)
      end
     end 
     
  end

  describe "PUT 'update'" do

    before(:each) do
      admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
      test_sign_in(admin)
      @task = FactoryGirl.create(:task)
    end   
   
    describe "failure" do
  
        before(:each) do
          @attr = {:name => ""}
        end
  
        it "should render the 'edit' page" do
          put :update, :id =>  @task, :task => @attr
          response.should render_template('edit')
        end
           
    end

    describe "success" do
 
          before(:each) do
            @attr = { :name => "New Task" }
          end         
    
          it "returns http success" do
            get 'edit', :id =>  @task
            response.should be_success
          end
   
          it "should change the task's name" do
            put :update, :id => @task, :task => @attr
            @task.reload
            @task.name.should  == @attr[:name]
          end
    
          it "should redirect to the task show page" do
            put :update, :id => @task, :task => @attr
            response.should redirect_to(task_path(@task))
          end
      
          it "should have a flash message" do
            put :update, :id => @task, :user => @attr
            flash[:success].should =~ /updated/
          end
          
      end 

  end

 
  describe "DELETE 'destroy'" do

    before(:each) do
      @task = FactoryGirl.create(:task)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @task
        response.should redirect_to(tasks_path)
      end
    end

    describe "as a non-admin user" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        test_sign_in(@user)
      end
      
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @task
        response.should redirect_to(tasks_path) 
      end
      
      it "should not show link to delete task" do
        ###gravatar_url = "http://gravatar.com/emails"
        ## How do I do this?
        response.should_not have_selector("a", :href => "delete",
                                         :content => "delete")
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the task" do
        lambda do
          delete :destroy, :id => @task
        end.should change(Task, :count).by(-1)
      end

      it "should redirect to the tasks page" do
        delete :destroy, :id => @task
        response.should redirect_to(tasks_path)
      end
    end
  end
  
end
