class AddAddressToOperation < ActiveRecord::Migration
  def change
    add_reference :operations, :address, index: true, foreign_key: true
  end
end
