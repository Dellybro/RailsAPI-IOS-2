class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :last_name
      t.string :first_name
      t.string :password
      t.string :password_digest
      t.string :bio
      t.string :auth_token
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :address
      t.string :propic

      t.timestamps null: false
    end
  end
end
