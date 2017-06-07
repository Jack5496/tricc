# Erstelle Nutzer, welche gleichzeitig Einsatzkräfte sind

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :firstname, :string, :null => false  #Vorname einer Person
      t.column :lastname, :string, :null => false   #Nachname einer Person
      t.column :password_digest, :string, :null => false #Passwort
      t.column :remember_digest, :string
      t.column :email, :string, :null => false  #Email
      t.column :admin, :boolean, :null => false #Ist der Nutzer ein Admin
      
      t.column :picture, :string        #Bild einer Person
      t.column :size, :float            #Größe als Float
      t.column :female, :boolean        #Sex, false=>Mann,
      t.column :information, :string    #Zusatzinformation
      t.column :device_type, :string    #Was für ein Gerät benutzt die Person zum
                                #ansehen der Seite; für Debug Informationen
      t.column :last_activ, :timestamp  #Wann war die Person zuletzt aktiv
      
      t.references :profession, :profession
      t.belongs_to :department, :department

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end