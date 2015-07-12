class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :client_id
      t.integer :provider_id
      t.string :request_message
      t.boolean :seen

      t.timestamps null: false
    end
  end
end
