FactoryGirl.define do
  factory :stats do
    stargazers_count 100
    subscribers_count 100
    forks_count 100
    rubygem_downloads_count 100
    rubygem_downloads_count_delta 0

    project
  end
end
