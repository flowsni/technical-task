class Add[mailStatus]ToLetters < ActiveRecord::Migration[4.2]
  def change
    add_column :letters, :[mail_status], :string
  end
end
