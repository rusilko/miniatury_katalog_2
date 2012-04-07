FactoryGirl.define do
  factory :user do
    name      "Tomek Rusilko"
    email     "tomek.rusilKo@gmail.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end