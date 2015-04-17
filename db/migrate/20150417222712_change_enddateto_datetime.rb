class ChangeEnddatetoDatetime < ActiveRecord::Migration
  def change
    change_column :Assignments, :due_date,  :datetime
  end
end
