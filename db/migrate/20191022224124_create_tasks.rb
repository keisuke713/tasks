class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :detail, null: false
      t.date :deadline, null: false
      t.integer :status, default: 0
      t.string :label

      t.timestamps
    end
  end
end
