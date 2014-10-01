FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@rubbby.co" }
    password 'TestPass'

    services { build_list :user_service, 1 }
  end

end
