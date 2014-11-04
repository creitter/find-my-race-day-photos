class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => { :large => "700x700", :medium => "300x300>", :thumb => "100x100>" }, 
    :default_url => "/images/:style/missing.png",
    :url  => "/assets/photos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
    
  after_image_post_process :load_exif
  
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :user
    
  def self.move_to_new_photographer(old_photographer, new_photographer) 
    photos_to_be_moved = Photo.where(user_id: old_photographer.id)
    photos_to_be_moved.each { |photo| 
      photo.user = new_photographer
      photo.save
    }
  end
  
  def load_exif
    exif = EXIFR::JPEG.new(image.queued_for_write[:original].path)

    location = Location.new(description: "A race occurred here")

    if not exif.nil? && exif.exif?
      self.date_taken = exif.date_time.to_date
      if not exif.gps.nil?
        location.longitude = exif.gps.longitude
        location.latitude = exif.gps.latitude
        location.altitude = exif.gps.altitude
        location.image_direction = exif.gps.image_direction
      end
    end
    location.save!
    self.location = location
  end
end
