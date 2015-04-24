class ChangeEnddatetoDatetime < ActiveRecord::Migration
  def change
    change_column :assignments, :due_date,  :datetime
  end
end
