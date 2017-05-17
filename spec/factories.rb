FactoryGirl.define do
  factory :user do
    first_name "first"
    last_name "user"
    email "first_user@example.com"
    phone_number "4245254034"
    password "foobar"
    password_confirmation "foobar"
  end
end