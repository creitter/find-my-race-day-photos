class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :save_return_to, only: [:show, :edit, :update]
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
    @state = :new
  end

  # GET /photos/1/edit
  def edit
    @state = :edit
  end

  # POST /photos
  # POST /photos.json
  def create
    params[:file].each {|file|
      image = file[1]
      @errors = []
      @photos = []
      @photo = Photo.create(image: image)
      @photo.user = current_user
      @photo.location.save!

      if @photo.save!
        @photos << @photo
      else
        @errors << @photo.error
      end
    }

    respond_to do |format|
      if @errors.empty?
        format.html { redirect_to @photo  , notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photos }
      else
        format.html { render action: 'new' }
        format.json { render json: @errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|      
      @photo.location.description = location_params[:description]
      @photo.location.save!
      
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

    def save_return_to
      # We don't have a return_to saved and the page was reloaded not redirected to
      if session[:return_to].nil? && request.referer.nil?
        session[:return_to] = photos_path
      elsif !request.referer.nil? # We do not have a reload, but a valid back url.
        session[:return_to] = request.referer
        # else we use the previously saved return_to url.
      end
      
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:person, :location, :tags, :note, :image => [])
    end
    
    def location_params
       params.require(:location).permit(:description)
    end
    
end
