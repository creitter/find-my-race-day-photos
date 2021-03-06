class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user!, except: [:index, :show, :new, :create]

  # GET /photos
  # GET /photos.json
  def index
    @photos = current_user.photos
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.create(photo_params)
    @photo.user = current_user
    @photo.location = load_location_info(@photo)
    
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      @photo.location = load_location_info(@photo)
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:person, :location, :tags, :note, :image)
    end
    
    def location_params
       params.require(:location).permit(:description)
    end
    
    # Load GPS and Location specific information for the photo
    def load_location_info(photo)  
      exif = EXIFR::JPEG.new(photo.image.path)
      location = Location.create(location_params)
      if not exif.nil? && exif.exif?
        photo.date_taken = exif.date_time.to_date
        if not exif.gps.nil?
          location.longitude = exif.gps.longitude
          location.latitude = exif.gps.latitude
          location.altitude = exif.gps.altitude
          location.image_direction = exif.gps.image_direction
        end
      end
      location.save!
      location
    end
end
