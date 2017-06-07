# Erstelle Adressen

class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.column :city, :string
      t.column :postcode, :integer, :null => false
      t.column :street, :string, :null => false
      t.column :building_number, :integer, :null => false
      t.column :secondary_address, :string

      t.timestamps null: false
    end
    add_index :addresses, [:postcode, :street, :building_number], unique: true
  end
end
