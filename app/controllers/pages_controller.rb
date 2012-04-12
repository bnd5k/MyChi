class PagesController < ApplicationController
  def home
    p current_user
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end
  
  def splash
    @title = "My City Rocks Me!"
  end
    
end
