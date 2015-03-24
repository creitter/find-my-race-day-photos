class Photo < ActiveRecord::Base

  belongs_to :user
  belongs_to :location
  belongs_to :event

  has_attached_file :image, :styles => { :large => "700x700", :medium => "300x300>", :thumb => "100x100>" }, 
    :default_url => "/images/:style/missing.png",
    :url  => "/assets/photos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
      
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/  

  after_image_post_process :load_location_info
  
  # Allow all Photos from a photographer be moved to a new photographer
  def self.move_to_new_photographer(old_photographer, new_photographer) 
    photos_to_be_moved = Photo.where(user_id: old_photographer.id)
    photos_to_be_moved.each { |photo| 
      photo.user = new_photographer
      photo.save!
    }
  end

  # Allow this photo to be moved to a new photographer
  def move_to_new_photographer(new_photographer)
    self.user = new_photographer
    self.save!
  end
  
  # After the photo has been uploaded, process the exif info it has.
  def load_location_info
    
    begin
      exif = EXIFR::JPEG.new(self.image.queued_for_write[:original].path)
  
      if not exif.nil? && exif.exif?
        
        if exif.date_time.present?
          self.date_taken = exif.date_time.to_date 
        else
          Rails.logger.debug "\n\n LOAD_LOCATION_INFO exif #{exif.inspect} \n\n"
          Rails.logger.debug "\n\n image #{self.image.inspect} \n\n"
          #self.date_taken = self.date_created
        end
        
        if not exif.gps.nil?
          longitude = exif.gps.longitude
          latitude = exif.gps.latitude
          altitude = exif.gps.altitude
          image_direction = exif.gps.image_direction
          description =  !longitude.nil? && !latitude.nil? ? "Map location available" : ""

          location = Location.create(description: description, longitude: exif.gps.longitude, latitude: exif.gps.latitude, altitude: exif.gps.altitude, image_direction:exif.gps.image_direction)
        else
          location = Location.create()
        end
      end
    rescue EXIFR::MalformedJPEG
      Rails.logger.error "Malformed JPG. Could not get EXIF data."
      location = Location.create()
    end
    self.location = location
  end
end
