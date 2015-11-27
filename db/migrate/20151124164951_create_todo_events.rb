class CreateTodoEvents < ActiveRecord::Migration
  def change
    create_table :todo_events do |t|
      t.string :event
      t.text :description
      t.datetime :date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :todo_events, [:user_id, :date]
  end
end
