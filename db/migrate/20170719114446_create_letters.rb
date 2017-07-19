class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :creator
      t.string :mail_from
      t.string :email
      t.string :mail_status
      t.string :comment

      t.timestamps null: false
    end
  end
end
