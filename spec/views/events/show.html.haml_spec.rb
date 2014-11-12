require 'rails_helper'

RSpec.describe "events/show", :type => :view do
  before(:each) do
    @event = assign(:event, Event.create!(
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
