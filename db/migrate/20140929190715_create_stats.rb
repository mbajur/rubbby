class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :project, index: true
      t.integer :stargazers_count
      t.integer :subscribers_count
      t.integer :forks_count

      t.timestamps
    end
  end
end
