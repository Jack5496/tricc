class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.column :operation_type, :string
      
      t.column :activ, :boolean, :null => false    #Activer Einsatz
      
      t.timestamp :time_started
    end
  end
end