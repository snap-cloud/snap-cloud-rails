class AddParentPermissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :parent_permission, :boolean, :default => false
  end
end
