class CreateAudienceMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :audience_members do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :cpf, null: false, unique: true
      t.timestamps
    end
  end
end
