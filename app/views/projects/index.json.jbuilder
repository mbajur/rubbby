json.array!(@projects) do |project|
  json.extract! project, :id, :name, :full_name, :description, :github_id, :homepage, :stargazers_count, :watchers_count, :forks_count, :subscribers_count, :parent_id, :source_id
  json.url project_url(project, format: :json)
end
