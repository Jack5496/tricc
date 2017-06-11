class AddUserToOperation < ActiveRecord::Migration
  def change
    #add_reference :operations, :chief, index: true, foreign_key: { to_table: :users }
    add_reference :operations, :chief, index: true, references: :users
  end
end
