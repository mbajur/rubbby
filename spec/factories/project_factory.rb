FactoryGirl.define do
  factory :project do
    full_name 'rails/rails'
    is_gem true
    rubygem_name 'rails'

    user
  end
end
