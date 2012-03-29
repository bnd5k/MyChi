require 'spec_helper'

describe HuntsController do
  render_views
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    
    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "All Hunts")
    end

    it "should have an element for each hunt" do
      get :index
      Hunt.paginate(:page => 1).each do |hunt|
        response.should have_selector("li", :content => hunt.name)
      end
    end
      
    it "should paginate hunts" do
      get :index
      response.should have_selector('div.pagination')
      response.should have_selector('span.disabled', :content => "Previous")
      response.should have_selector('a', :href => "/hunts?page=2",
                                           :content => "2")
      response.should have_selector('a', :href => "/hunts?page=2",
                                           :content => "Next")
    end 
      
    describe "for signed in user who aren't admins" do
      
      before(:each) do
        @user = FactoryGirl.create(:user)
      end

      it "should not show edit option" do
        get 'index'
        Hunt.paginate(:page => 1).each do |hunt|              
          response.should_not have_selector('a', :href => edit_hunt_path(hunt), :content => 'edit')
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
        Hunt.paginate(:page => 1).each do |hunt|               
          response.should have_selector('a', :href => edit_hunt_path(hunt), :content => 'edit')
        end 
      end
            
      it "should show delete link" do
        get 'index'
        Hunt.paginate(:page => 1).each do |hunt|
          response.should have_selector('a', :href => hunt_path(hunt)   , :content => 'delete')
        end
      end

    end     
  end

  describe "GET 'show'" do
    before(:each) do
      @hunt = FactoryGirl.create(:hunt)
    end

    it "should be successful" do
      get :show, :id => @hunt
      response.should be_success
    end

    it "should find the right hunt" do
      get :show, :id => @hunt
      assigns(:hunt).should == @hunt
    end

    it "should have the right title" do
      get :show, :id => @hunt
      response.should have_selector("title", :content => @hunt.name)
    end

    it "should include the hunt's name" do
      get :show, :id => @hunt
      response.should have_selector("h1", :content => @hunt.name)
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
        response.should have_selector("title", :content => "New Hunt")

      end
   
      it "should have a name field" do
        get 'new'
        response.should have_selector("input[name='hunt[name]'][type='text']")
      end   
    end    
  end

  describe "POST 'create'" do

    describe "failure" do
      before(:each) do
        @attr = { :name => "" }
      end

     it "should render the 'new' page" do
        post :create, :hunt => @attr
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, :hunt => @attr
        response.should have_selector("title", :content => "New Hunt")
      end

      it "should not create a hun" do
        lambda do
          post :create, :hunt => @attr
        end.should_not change(Hunt, :count)
      end
    end
    
    describe "success" do
 
      before(:each) do
          @hunt = FactoryGirl.create(:hunt)
          @attr = { :name => "New Hunt" }
      end
  
      it "should create a hunt" do
        lambda do
          post :create, :hunt => @attr
        end.should change(Hunt, :count).by(1)  
      end
  
      it "should redirect to the hunts show page" do
        post :create, :hunt => @attr
        response.should redirect_to(hunts_path)
      end    
        
      it "should have a success message" do
        post :create, :hunt=> @attr
        flash[:success].should =~ /hunt created/i
      end               
    end
     
  end

  describe "GET 'edit'" do
    
    before(:each) do
       @hunt = FactoryGirl.create(:hunt)
    end
 
    describe "as a non-signed-in user" do
      it "should deny access" do
        get :edit, :id => @hunt
        response.should redirect_to(hunts_path)
      end
     end 
     
  end

  describe "PUT 'update'" do

    before(:each) do
      admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
      test_sign_in(admin)
      @hunt = FactoryGirl.create(:hunt)
    end   
   
    describe "failure" do
  
        before(:each) do
          @attr = {:name => ""}
        end
  
        it "should render the 'edit' page" do
          put :update, :id =>  @hunt, :hunt => @attr
          response.should render_template('edit')
        end
           
    end

    describe "success" do
 
          before(:each) do
            @attr = { :name => "New Hunt" }
          end         
    
          it "returns http success" do
            get 'edit', :id =>  @hunt
            response.should be_success
          end
   
          it "should change the hunt's name" do
            put :update, :id => @hunt, :hunt => @attr
            @hunt.reload
            @hunt.name.should  == @attr[:name]
          end
    
          it "should redirect to the hunt show page" do
            put :update, :id => @hunt, :hunt => @attr
            response.should redirect_to(hunt_path(@hunt))
          end
      
          it "should have a flash message" do
            put :update, :id => @hunt, :user => @attr
            flash[:success].should =~ /updated/
          end
          
      end 

  end

 
  describe "DELETE 'destroy'" do

    before(:each) do
      @hunt = FactoryGirl.create(:hunt)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @hunt
        response.should redirect_to(hunts_path)
      end
    end

    describe "as a non-admin user" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        test_sign_in(@user)
      end
      
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @hunt
        response.should redirect_to(hunts_path) 
      end
      
      it "should not show link to delete hunt" do
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

      it "should destroy the hunt" do
        lambda do
          delete :destroy, :id => @hunt
        end.should change(Hunt, :count).by(-1)
      end

      it "should redirect to the hunts page" do
        delete :destroy, :id => @hunt
        response.should redirect_to(hunts_path)
      end
    end
  end
  
end
