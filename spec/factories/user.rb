FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "test_#{n}@factory.com" }
    password "password"
    guest false
  end

  # This will use the User class (Admin would have been guessed)
  factory :guest_user, class: User do
    sequence(:email){|n| "testguest_#{n}@factory.com" }
    password "password"
    guest true
  end
end