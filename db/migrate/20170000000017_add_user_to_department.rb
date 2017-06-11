class AddUserToDepartment < ActiveRecord::Migration
  def change
    #add_reference :departments, :chief, index: true, foreign_key: { to_table: :users }
    add_reference :departments, :chief, index: true, references: :users
  end
end
