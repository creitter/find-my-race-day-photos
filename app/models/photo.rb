class Photo < ActiveRecord::Base

  belongs_to :user
  belongs_to :location

  has_attached_file :image, :styles => { :large => "700x700", :medium => "300x300>", :thumb => "100x100>" }, 
    :default_url => "/images/:style/missing.png",
    :url  => "/assets/photos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
      
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/  

  after_image_post_process :load_location_info
  
  def self.move_to_new_photographer(old_photographer, new_photographer) 
    photos_to_be_moved = Photo.where(user_id: old_photographer.id)
    photos_to_be_moved.each { |photo| 
      photo.user = new_photographer
      photo.save
    }
  end
  
  def load_location_info
    exif = EXIFR::JPEG.new(self.image.queued_for_write[:original].path)
  
    if not exif.nil? && exif.exif?
      self.date_taken = exif.date_time.to_date if exif.date_time.present?
      if not exif.gps.nil?
        longitude = exif.gps.longitude
        latitude = exif.gps.latitude
        altitude = exif.gps.altitude
        image_direction = exif.gps.image_direction
        location = Location.create(longitude: exif.gps.longitude, latitude: exif.gps.latitude, altitude: exif.gps.altitude, image_direction:exif.gps.image_direction)
      else
        location = Location.create()
      end
    end
    self.location = location
  end
end
