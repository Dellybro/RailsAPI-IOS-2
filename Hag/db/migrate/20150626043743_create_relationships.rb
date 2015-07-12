class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :client_id
      t.integer :provider_id

      t.timestamps null: false
    end
    add_index :relationships, :provider_id
    add_index :relationships, :client_id
    add_index :relationships, [:provider_id, :client_id], unique: true
  end
end
