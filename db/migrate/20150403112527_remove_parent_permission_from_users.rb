class RemoveParentPermissionFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :parent_permission
  end
end
