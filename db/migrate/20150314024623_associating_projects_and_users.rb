class AssociatingProjectsAndUsers < ActiveRecord::Migration
  def change
  	add_column :projects, :user_id, :integer
  	add_foreign_key :projects, :users, column: :user_id, primary_key: "id"
  end
end
