class AddAddressToDepartment < ActiveRecord::Migration
  def change
    add_reference :departments, :address, index: true, foreign_key: true
  end
end
