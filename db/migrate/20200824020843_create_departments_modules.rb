class CreateDepartmentsModules < ActiveRecord::Migration[6.0]
  def change
    create_table :departments_modules do |t|
      t.references :departments, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
