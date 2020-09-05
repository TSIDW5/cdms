class CreateDepartmentModules < ActiveRecord::Migration[6.0]
  def change
    create_table :department_modules do |t|
      t.references :department, null: false, foreign_key: true
      t.string :name, index: { unique: true }
      t.text :description

      t.timestamps
    end
  end
end
