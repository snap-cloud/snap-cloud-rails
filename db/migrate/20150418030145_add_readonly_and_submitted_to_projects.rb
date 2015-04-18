class AddReadonlyAndSubmittedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :read_only, :boolean, default: false
    add_column :projects, :submitted, :boolean, default: false
  end
end
