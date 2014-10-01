class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :projects_count

      t.timestamps
    end
    add_index :tags, :slug, unique: true
  end
end
