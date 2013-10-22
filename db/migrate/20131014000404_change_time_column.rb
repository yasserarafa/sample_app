class ChangeTimeColumn < ActiveRecord::Migration
  def change
  	change_column :articles, :estimated_time, :integer
  end
end