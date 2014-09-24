class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # # https://github.com/plataformatec/devise/wiki/How-To:-Create-a-guest-user
#   skip_before_filter :verify_authenticity_token, :only => [:receive_guest]
#
#
#   helper_method :current_or_guest_user
#
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
    move_content guest_user, current_user if params["move"] == true
  end
  

  def sign_up (resource_or_scope, *args)
    super 
    move_content guest_user, current_user if params["move"] == true
  end
  
  private
  
  def move_content(guest, current) 
    if guest_user && guest_user.photos.length>0
      Photo.move_to_new_photographer(guest_user,current_user)
    end

    #Clear out the session[:guest_user_id]
    session[:guest_user_id] = nil
    
  end
  
  
  def create_guest_user
   Rails.logger.debug "/n/n create_guest_user /n/n"
   u = User.create(email: "guest_#{Time.now.to_i}#{rand(100)}@example.com", guest: true)
   u.save!(validate: false)
   session[:guest_user_id] = u.id
   Rails.logger.debug "/n/n u #{u.inspect} /n/n"
   
   u
  end
end
