class AddDeviseFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      ## Database authenticatable
      t.column :encrypted_password, :string

      ## Recoverable
      t.column :reset_password_token, :string
      t.column :reset_password_sent_at, :datetime

      ## Rememberable
      t.column :remember_created_at, :datetime
    end

    add_index :users, :reset_password_token, unique: true
  end
end
