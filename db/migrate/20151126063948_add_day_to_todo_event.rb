class AddDayToTodoEvent < ActiveRecord::Migration
  def change
    add_column :todo_events, :stretch, :integer
  end
end
