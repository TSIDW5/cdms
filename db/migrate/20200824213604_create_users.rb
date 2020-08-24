class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :register_number
      t.string :cpf
      t.boolean :status

      t.timestamps
    end
  end
end
