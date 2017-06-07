class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.belongs_to :user, :user, :null => false    #Einsatzleiter
      t.column :activ, :boolean, :null => false    #Activer Einsatz
      t.references :department, :department, :null => false    #Einzentrale
      
      t.timestamp :time_started
    end
  end
end