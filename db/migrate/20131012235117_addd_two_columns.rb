class AdddTwoColumns < ActiveRecord::Migration
  def change
  	add_column :articles, :estimated_time , :string
  end
end
