class CreateJoinTableProfessionUser < ActiveRecord::Migration
  def change
    create_join_table :Professions, :Users do |t|
      t.index [:profession_id, :user_id]
      t.index [:user_id, :profession_id]
    end
  end
end
