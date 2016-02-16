class CreateEntrances < ActiveRecord::Migration
  def change
    create_table :entrances do |t|
      t.string :name
      t.string :ip
      t.integer :port
      t.integer :status, :default => '1'

      t.timestamps null: false
    end
    add_index :entrances, :name, unique: true
    add_index :entrances, :ip, unique: true
  end
end
