class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :type
      t.integer :provider_id

      t.timestamps null: false
    end
  end
end
