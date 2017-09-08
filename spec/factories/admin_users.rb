FactoryGirl.define do
  factory :admin_user do
    email 'email@email.com'
    password 'password'
    password_confirmation 'password'
  end
end