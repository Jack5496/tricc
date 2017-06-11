# Erstelle neue Berufsklasse für spätere Einsatzkräfte

class CreateProfessions < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.column :name, :string, :null => false #Bezeichnung für die Berufsklasse

      t.timestamps null: false
    end
    add_index :professions, :name, unique: true
  end
end
