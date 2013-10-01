class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.string :description
      t.integer :user_id
      t.integer :item_id
      t.integer :favorite
      t.string :url

      t.timestamps
    end
  end
end