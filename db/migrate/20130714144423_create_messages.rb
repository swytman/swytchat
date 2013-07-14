class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end

    add_index :messages, [:user_id, :created_at]
    add_index :messages, [:room_id, :created_at]

  end
end
