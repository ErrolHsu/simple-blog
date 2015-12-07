class RenameEventColumn < ActiveRecord::Migration
  def change
  	rename_column :todo_events, :event, :title
  end
end
