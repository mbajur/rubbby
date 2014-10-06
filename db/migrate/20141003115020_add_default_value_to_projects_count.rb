class AddDefaultValueToProjectsCount < ActiveRecord::Migration
  def change
    change_column :tags, :projects_count, :integer, :default => 0
  end
end
