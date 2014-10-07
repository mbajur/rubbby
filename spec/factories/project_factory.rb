FactoryGirl.define do
  factory :project do
    sequence(:full_name) { |n| "rails/rails#{n}" }
    is_gem true
    sequence(:rubygem_name) { |n| "rails#{n}" }

    user
  end
end
