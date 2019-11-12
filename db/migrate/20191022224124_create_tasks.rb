class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :detail, null: false
      t.date :deadline, null: false
      t.integer :status, default: 0
      t.string :label, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
