# Erstelle neues Department (Einsatzzentrale)

class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.belongs_to :user, :user, :null => false
      t.column :name, :string, :null => false            #Name der Einsatzzentrale
      t.references :address, :address, :null => false            #Adresse der Einsatzzentrale
      t.timestamps null: false
      
    end
    add_index :departments, :name, unique: true
  end
end
