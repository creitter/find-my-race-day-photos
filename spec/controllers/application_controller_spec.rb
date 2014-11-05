require 'rails_helper'

describe ApplicationController do
  describe "handle_this" do
    it "does not call move_content" do
      params = {"user"=>{"email"=>"cori@bob.com", "password"=>"[FILTERED]", "remember_me"=>"0"}, "commit"=>"Login", "move"=>""}
      expect(controller).to_not receive(:move_content)
      controller.handle_this params
    end

    it "does call move_content" do
      controller.stub(current_user: FactoryGirl.create(:user), guest_user: FactoryGirl.create(:guest_user))
      params = {"user"=>{"email"=>"cori@bob.com", "password"=>"[FILTERED]", "remember_me"=>"0"}, "commit"=>"Login", "move"=>"true"}
      expect(controller).to receive(:move_content)
      controller.handle_this params
    end
  end
end