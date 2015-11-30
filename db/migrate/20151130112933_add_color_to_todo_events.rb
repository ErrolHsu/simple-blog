class AddColorToTodoEvents < ActiveRecord::Migration
  def change
    add_column :todo_events, :color, :string
  end
end
