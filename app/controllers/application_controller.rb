class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
# # https://github.com/plataformatec/devise/wiki/How-To:-Create-a-guest-user
#   skip_before_filter :verify_authenticity_token, :only => [:receive_guest]

  def current_user
    super || guest_user
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
   # Cache the value the first time it's gotten.
   @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
   @cached_guest_user
  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user
  end
  
  def sign_in (resource_or_scope, *args)
    super
    handle_this params
  end
  
  def sign_up (resource_or_scope, *args)
    super 
    handle_this params
  end
  
  def handle_this(params)
     move_content guest_user, current_user if params["move"] == "true"
  end
  
end
