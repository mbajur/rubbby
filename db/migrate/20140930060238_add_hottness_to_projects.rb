class AddHottnessToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hottness, :integer, default: 0
  end
end
