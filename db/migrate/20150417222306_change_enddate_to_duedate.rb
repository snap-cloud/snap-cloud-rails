class ChangeEnddateToDuedate < ActiveRecord::Migration
  def change
    rename_column :Assignments, :end_date, :due_date
  end
end
