class EventsController < ApplicationController
  include EventsHelper
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  def index
    @events = Event.all
    respond_with(@events)
  end

  def show
    respond_with(@event)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.save
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:description, :distance, :website, :event_date, :start_address, :start_city, :start_state, :start_province, :country, :end_address, :end_city, :end_province, :end_state, :longitude, :latitude)
    end
end
