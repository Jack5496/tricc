class AddDepartmentToOperation < ActiveRecord::Migration
  def change
    add_reference :operations, :department, index: true, foreign_key: true
  end
end
