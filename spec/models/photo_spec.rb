require 'rails_helper'

describe Photo do
  describe "move_to_new_photographer" do
    let(:guest_user) {FactoryGirl.create :guest_user}
    let(:user) {FactoryGirl.create :user}
    let(:photo) {FactoryGirl.create :photo, user:guest_user}

    context "with Photo class" do
      it "moves photos from one photographer to another" do
        expect(photo.user).to eq(guest_user)
        Photo.move_to_new_photographer(guest_user, user)
        photo.reload
        expect(photo.user).to eq(user)
      end
    end
    
    context "with photo instance" do
      it "moves photos from one photographer to another" do
        expect(photo.user).to eq(guest_user)
        photo.move_to_new_photographer(user)
        photo.reload
        expect(photo.user).to eq(user)
      end
      
      context "with exif information" do
        #TODO: Look up how to mock out exif data on an image

        it "load gps data" do
        end
        
        it "load date taken" do
        end
      end
      
      context "with out exif information" do
        #TODO: Look up how to mock out exif data on an image

        it "does not load gps data" do
        end
        
        it "does not load date taken" do
        end
      end
    end
  end
end