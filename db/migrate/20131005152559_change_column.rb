class ChangeColumn < ActiveRecord::Migration
  def change
  	change_column :articles, :item_id, :string
  end
end
