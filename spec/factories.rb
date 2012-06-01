FactoryGirl.define do
  factory :user do
    #name      "Tomek Rusilko"
    sequence(:name) { |n| "Person #{n}" }
    #email     "tomek.rusilko@gmails.com"
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    #content "Lorem ipsum"
    sequence(:content) { |n| "Lorem ipsum #{n}" } #Faker::Lorem.sentence(5)
    user
  end
end