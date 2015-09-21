class AddStateToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :state, :integer, default: 1
    add_index :articles, :state
  end
end
