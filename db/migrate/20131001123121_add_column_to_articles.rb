class AddColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :found, :integer
  end
end
