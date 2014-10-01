FactoryGirl.define do
  factory :user_service do
    provider 'github'
    token 'abc123'
    sequence(:uid) { |n| n }
  end

end
