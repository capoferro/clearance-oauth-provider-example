class AddUserIdToApplications < ActiveRecord::Migration
  def self.up
    add_column :applications, :user_id, :integer, null: false
  end

  def self.down
    remove_column :applications, :user_id
  end
end
