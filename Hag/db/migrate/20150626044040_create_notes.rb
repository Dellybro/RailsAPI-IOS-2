class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :message_id
      t.integer :user_unique_id
      t.string :message

      t.timestamps null: false
    end
  end
end
