class CreateDepartmentUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :department_users do |t|
      t.references :department, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
    add_index :department_users, [:department_id, :user_id], unique: true
  end
end
