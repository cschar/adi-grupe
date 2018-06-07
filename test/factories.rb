# This will guess the User class
FactoryBot.define do
  # factory :user do
  #   first_name "John"
  #   last_name  "Doe"
  #   admin false
  # end

  factory :user do |user|
    user.name                   "Test User"
    user.email                  "user@example.com"
    user.password               "password"
    user.password_confirmation  "password"
  end

  # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  #   admin      true
  # end

end