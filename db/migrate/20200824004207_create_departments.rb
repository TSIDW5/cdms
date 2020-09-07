class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.text :description
      t.string :initials, index: { unique: true }
      t.string :local
      t.string :phone
      t.string :email, index: { unique: true }

      t.timestamps
    end
  end
end
