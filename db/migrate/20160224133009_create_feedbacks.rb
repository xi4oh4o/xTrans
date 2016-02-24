class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :username
      t.integer :user_id
      t.text :content
      t.integer :status, :default => 0

      t.timestamps null: false
    end
  end
end
