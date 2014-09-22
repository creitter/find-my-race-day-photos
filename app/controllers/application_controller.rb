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
#
#   # if user is logged in, return current_user, else return guest_user
#    def current_or_guest_user
#      Rails.logger.debug "/n/n in current_or_guest_user #{current_user}/n/n "
#      if current_user
#        if session[:guest_user_id]
#          logging_in
#          guest_user.destroy
#          session[:guest_user_id] = nil
#        end
#        current_user
#      else
#        guest_user
#      end
#    end
#
   # find guest_user object associated with the current session,
   # creating one as needed
   def guest_user
     Rails.logger.debug "\n\n In Guest User \n\n"

     # Cache the value the first time it's gotten.
     @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
     @cached_guest_user
   rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
      session[:guest_user_id] = nil
      guest_user
   end
#
#    private
#
#    # called (once) when the user logs in, insert any code your application needs
#    # to hand off from guest_user to current_user.
#    def logging_in
#      # For example:
#      # guest_comments = guest_user.comments.all
#      # guest_comments.each do |comment|
#        # comment.user_id = current_user.id
#        # comment.save!
#      # end
#    end
#
   def create_guest_user
     Rails.logger.debug "/n/n create_guest_user /n/n"
     u = User.create(email: "guest_#{Time.now.to_i}#{rand(100)}@example.com", guest: true)
     u.save!(validate: false)
     session[:guest_user_id] = u.id
     Rails.logger.debug "/n/n u #{u.inspect} /n/n"
     
     u
   end
end
