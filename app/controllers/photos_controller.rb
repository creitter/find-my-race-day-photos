class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :save_return_to, only: [:show, :edit, :update]
  after_action :save_to_event, only: [:create]
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
    @errors = []
    @photos = []

    params[:file].each {|file|
      image = file[1]
      @photo = Photo.create(image: image)
      @photo.user = current_user
      @photo.location.save!

      if @photo.save!
        @photos << @photo
      else
        @errors << @photo.error
      end
    }
    
    Rails.logger.debug "\n\n @photos (#{@photos.count}) - #{@photos.inspect} \n\n"

    respond_to do |format|
      if @errors.empty?
        format.html { redirect_to @photo  , notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: photo_url(@photos)}
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
    
    def save_to_event
      Rails.logger.debug "\n\n In SAVE_TO_EVENT:: @photos #{@photos} \n\n"

      begin
        sorted_photos = @photos.sort_by!{|photo| photo.date_taken }
      rescue NoMethodError => e
        Rails.logger.debug "\n\n Error #{e.message} \n\n"
      end
      # Using the photo, determine if we already have an event based on the photo's date, location and possibly entered event. (start with date_taken first)
      
      # If we have an event for this date (/location and/or entered date criteria), then assign it.
      # If we don't create a blank event and get the Photographer to fill it out.
      @events = []
      @events_error = []
      
      sorted_photos.each {|photo| 
        @event = Event.where(event_date: photo.date_taken)
        Rails.logger.debug "\n\n @event in sorted_photos #{@event.inspect} \n\n"
        if @event.empty? 
          @event = Event.new(description: "New Event", event_date: photo.date_taken)
          if @event.save
            photo.event = @event
            photo.save
            #TODO: Add error handling here.
            @events << @event
          else
            @events_error << "Event not saved #{@event}"
          end
          Rails.logger.debug "\n\n NEW @event in sorted_photos #{@event.inspect} \n\n"
        else
          @events << @event
          #TODO: Add error handling here.
          photo.event = @event.first
          Rails.logger.info "\n\n There was more than one Event found matching this criteria #{@event.inspect} \n\n"
          photo.save
        end
      }

      Rails.logger.debug "\n\n @events #{@events.inspect} \n\n"
      Rails.logger.debug "\n\n @events_error #{@events_error.inspect} \n\n"
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:person, :location, :tags, :note, :image => [])
    end
    
    def location_params
       params.require(:location).permit(:description)
    end
    
end
