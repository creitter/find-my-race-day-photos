FactoryGirl.define do
  factory :user do |user|
    user.email {"user_#{rand(1000).to_s}@factory.com" }
    user.password "password"
    user.guest false
  end

  # This will use the User class (Admin would have been guessed)
  factory :guest_user, class: User do |guest_user|
    guest_user.email {"guest_#{rand(1000).to_s}@factory.com" }
    guest_user.password "password"
    guest_user.guest true
  end
end