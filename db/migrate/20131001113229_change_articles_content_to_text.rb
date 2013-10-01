class ChangeArticlesContentToText < ActiveRecord::Migration
  def change
  	change_column :articles, :content, :text, :limit => nil
  	change_column :articles, :description, :text, :limit => nil
  end
end
