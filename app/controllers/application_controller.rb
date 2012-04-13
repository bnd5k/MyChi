class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter(:except => [:splash, :create]) do
    redirect_to root_path
  end

   
  
end
