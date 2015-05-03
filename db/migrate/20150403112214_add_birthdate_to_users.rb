class AddBirthdateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthdate, :date
    add_column :users, :username, :string
    add_column :users, :parent_permission, :boolean, defualt: false
  end
end
