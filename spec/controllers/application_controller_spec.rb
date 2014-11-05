require 'rails_helper'

describe ApplicationController, :type => :controller do
  describe "handle_this" do
    it "does not call move_content" do
      params = {"user"=>{"email"=>"cori@bob.com", "password"=>"[FILTERED]", "remember_me"=>"0"}, "commit"=>"Login", "move"=>""}
      controller.should_not_receive(:move_content)
      controller.handle_this params
    end

    it "does call move_content" do
      controller.stub(:current_user => User.new, :guest_user => User.new)
      params = {"user"=>{"email"=>"cori@bob.com", "password"=>"[FILTERED]", "remember_me"=>"0"}, "commit"=>"Login", "move"=>"true"}
      controller.should_receive(:move_content)
      controller.handle_this params
    end
  end
end