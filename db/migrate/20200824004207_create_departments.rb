class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.text :description
      t.string :initials
      t.string :local
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
