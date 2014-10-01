class AddUserIdAndOwnerIdToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :user, index: true
    add_column :projects, :owner_id, :integer
  end
end
