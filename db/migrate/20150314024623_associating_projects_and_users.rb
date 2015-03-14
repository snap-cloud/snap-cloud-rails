class AssociatingProjectsAndUsers < ActiveRecord::Migration
  def change
  	add_foreign_key :projects, :users, column: :owner, primary_key: "id"
  end
end
