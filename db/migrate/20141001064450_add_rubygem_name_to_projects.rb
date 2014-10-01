class AddRubygemNameToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :rubygem_name, :string
    add_index :projects, :rubygem_name, unique: true
  end
end
