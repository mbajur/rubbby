class AddIsGemAndIsAppToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :is_gem, :boolean, default: false
    add_column :projects, :is_app, :boolean, default: false
  end
end
