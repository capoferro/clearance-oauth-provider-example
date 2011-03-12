class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.string :url, null: false
      t.string :client_id, null: false
      t.string :client_secret, null: false
      t.string :redirect_uri, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :applications
  end
end
