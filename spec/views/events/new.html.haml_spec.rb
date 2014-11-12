require 'rails_helper'

RSpec.describe "events/new", :type => :view do
  before(:each) do
    assign(:event, Event.new(
      :description => "",
      :distance => "",
      :website => "",
      :event_date => "",
      :start_address => "",
      :start_city => "",
      :start_state => "",
      :start_province => "",
      :country => "",
      :end_address => "",
      :end_city => "",
      :end_province => "",
      :end_state => "",
      :longitude => "",
      :latitude => ""
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_description[name=?]", "event[description]"

      assert_select "input#event_distance[name=?]", "event[distance]"

      assert_select "input#event_website[name=?]", "event[website]"

      assert_select "input#event_event_date[name=?]", "event[event_date]"

      assert_select "input#event_start_address[name=?]", "event[start_address]"

      assert_select "input#event_start_city[name=?]", "event[start_city]"

      assert_select "input#event_start_state[name=?]", "event[start_state]"

      assert_select "input#event_start_province[name=?]", "event[start_province]"

      assert_select "input#event_country[name=?]", "event[country]"

      assert_select "input#event_end_address[name=?]", "event[end_address]"

      assert_select "input#event_end_city[name=?]", "event[end_city]"

      assert_select "input#event_end_province[name=?]", "event[end_province]"

      assert_select "input#event_end_state[name=?]", "event[end_state]"

      assert_select "input#event_longitude[name=?]", "event[longitude]"

      assert_select "input#event_latitude[name=?]", "event[latitude]"

    end
  end
end
