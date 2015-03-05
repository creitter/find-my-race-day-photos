class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    if guest_user && guest_user.has_photos?
      flash[:notice] = "Guest has photos"
      @has_photos_to_upload = true
    end
      
    super
  end

  # POST /resource/sign_in
  def create
    super
    
    if params[:user][:move_photos] == "1"
      move_content guest_user, current_user 
    end
  end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
  
end
