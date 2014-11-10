class MainController < ApplicationController
  def index
    @photo = Photo.new
  end
end
