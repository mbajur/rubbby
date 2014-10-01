class AddUserIdAndIsPendingToTags < ActiveRecord::Migration
  def change
    add_column :tags, :user_id, :integer
    add_column :tags, :is_accepted, :boolean, default: false
  end
end
