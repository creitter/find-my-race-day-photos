class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :move_photos
  
  def photos 
    Photo.where(user_id: id)
  end
   
  def has_photos?
    #TODO: There is probably a more efficient way to do this.
    Photo.where(user_id: id).count > 0
  end
   
end
