FactoryGirl.define do
  factory :photo do
    image File.new(Rails.root + 'spec/fixtures/images/JohnAndShirley.JPG')
    user
  end
end