class CreateModuleUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :module_users do |t|
      t.references :department_module, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
    add_index :module_users, [:department_module_id, :user_id], unique: true
  end
end
