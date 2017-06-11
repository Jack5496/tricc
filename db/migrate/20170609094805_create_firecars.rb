class CreateFirecars < ActiveRecord::Migration
  def change
    create_table :firecars do |t|
      
      t.column :name, :string, :null => false  #Vorname einer Person
      t.column :size, :float            #Größe als Float

      t.timestamps null: false
    end
  end
end
