class AddIndexToUserEmail < ActiveRecord::Migration
  def change
  	add_column :providers, :email, :string
  	add_column :clients, :email, :string
  	add_index :providers, :email, unique: true
  	add_index :clients, :email, unique: true
  end
end
