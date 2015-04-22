class ChangeEnddateToDuedate < ActiveRecord::Migration
  def change
    rename_column :assignments, :end_date, :due_date
  end
end
