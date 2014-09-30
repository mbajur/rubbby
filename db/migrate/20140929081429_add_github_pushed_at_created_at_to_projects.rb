class AddGithubPushedAtCreatedAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :github_pushed_at, :datetime
    add_column :projects, :github_created_at, :datetime
  end
end
