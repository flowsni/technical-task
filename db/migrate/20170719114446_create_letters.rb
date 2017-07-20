class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :url
      t.string :email
      t.string :mail_status
      t.string :comment

      t.timestamps null: false
    end
    add_index :letters, [:created_at, :mail_status]
  end
end
