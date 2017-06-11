class ProfessionsUsers < ActiveRecord::Migration
  def change
    create_table :professions_users, :id => false do |t|
      t.integer :profession_id
      t.integer :user_id
    end
  end
end
