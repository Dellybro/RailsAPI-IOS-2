class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	
    	t.integer :user_id
        t.string :provider_id
        t.string :client_id
        t.string :messageTitle

      t.timestamps null: false
    end
  end
end
