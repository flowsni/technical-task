class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :url, index: true
      t.string :email, index: true
      t.string :mail_status, index: true
      t.string :comment
      t.timestamps null: false
    end
  end
end
