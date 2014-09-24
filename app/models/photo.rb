class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => { :large => "700x700", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
    belongs_to :user
    
    def self.move_to_new_photographer(old_photographer, new_photographer) 
      photos_to_be_moved = Photo.where(user_id: old_photographer.id)
      photos_to_be_moved.each { |photo| 
        photo.user = new_photographer
        photo.save
      }
    end
end
