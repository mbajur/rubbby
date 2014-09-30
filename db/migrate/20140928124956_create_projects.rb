class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :full_name
      t.text :description
      t.integer :github_id
      t.string :homepage
      t.integer :stargazers_count
      t.integer :watchers_count
      t.integer :forks_count
      t.integer :subscribers_count
      t.integer :parent_id
      t.integer :source_id

      t.timestamps
    end
  end
end
