class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
 
# before_filter :redirect_to_root_path

#def redirect_to_root_path
#  redirect_to root_path
#end


 before_filter(:except => :splash) do
   redirect_to root_path
 end
 
 #root_path # pages_splash_path #root_path "pages#splash"
 
# before_filter redirect_to root_path
 
 ## def handle_unverified_request
  #  raise ActionController::InvalidAuthenticityToken
  #end    
  
end
