class AddBlogTitleToUser < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :about_me, :text
  end
end
