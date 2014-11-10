require 'rails_helper'

describe ApplicationController do
  describe "handle_guest_to_loggedin" do
    it "does not call move_content" do
      params = {"user"=>{"email"=>"cori@bob.com", "password"=>"[FILTERED]", "remember_me"=>"0"}, "commit"=>"Login", "move"=>""}
      expect(controller).to_not receive(:move_content)
      controller.handle_guest_to_loggedin params
    end

    it "does call move_content" do
      controller.stub(current_user: FactoryGirl.create(:user), guest_user: FactoryGirl.create(:guest_user))
      params = {"user"=>{"email"=>"cori@bob.com", "password"=>"[FILTERED]", "remember_me"=>"0"}, "commit"=>"Login", "move"=>"true"}
      expect(controller).to receive(:move_content)
      controller.handle_guest_to_loggedin params
    end
  end
  
  describe 'guest_user' do
    # it "has a session guest user" do
 #      controller.stub(guest_user_id: FactoryGirl.create(:guest_user).id)
 #      expect(controller).to
 #    end
 #
 #    it "has not a session guest user" do
 #    end
    
   #  @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
   #  @cached_guest_user
   # rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
   #   session[:guest_user_id] = nil
   #   guest_user
   # end
 end
end