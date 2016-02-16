class CreateTunnels < ActiveRecord::Migration
  def change
    create_table :tunnels do |t|
      t.string :name
      t.integer :user_id
      t.integer :entrance_id
      t.integer :entrance_port, :default => '30000'
      t.string :target_address
      t.integer :destination_port
      t.integer :status, :default => '0'

      t.timestamps null: false
    end
    add_index :tunnels, :user_id
    add_index :tunnels, :entrance_id
    add_index :tunnels, :entrance_port
  end
end
