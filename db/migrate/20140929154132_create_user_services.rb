class CreateUserServices < ActiveRecord::Migration
  def change
    create_table :user_services do |t|
      t.integer :uid
      t.references :user, index: true
      t.string :provider
      t.string :token

      t.timestamps
    end
  end
end
