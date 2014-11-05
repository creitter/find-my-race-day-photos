FactoryGirl.define do
  factory :photo do
    image File.new(Rails.root + 'spec/fixtures/images/rails.png')
    user
  end
end