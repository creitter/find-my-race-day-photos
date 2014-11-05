require 'rails_helper'

describe ApplicationHelper do  
  describe "move_content" do
    let(:guest) { FactoryGirl.create(:guest_user) }
    let(:current) { FactoryGirl.create(:user) }
    let(:photos) { [FactoryGirl.create(:photo), FactoryGirl.create(:photo)]}
    
    # TODO add photos to the guest_user account

    it "does move content from guest user to current user" do
      # TODO call the method
      helper.move_content(guest, current)
      
      # TODO reload guest and current users
      
      # TODO verify guest no longer has photos and user has the photos created above.
    end
  end
end