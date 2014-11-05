module ApplicationHelper
  
  def move_content(guest, current) 
    if guest && guest.photos.length>0
      Photo.move_to_new_photographer(guest,current)
    end

    #Clear out the session[:guest_user_id]
    session[:guest_user_id] = nil
  end
  
  def create_guest_user
   user = User.create(email: "guest_#{Time.now.to_i}#{rand(100)}@example.com", guest: true)
   user.save!(validate: false)
   session[:guest_user_id] = user.id
   user
  end
  
end
