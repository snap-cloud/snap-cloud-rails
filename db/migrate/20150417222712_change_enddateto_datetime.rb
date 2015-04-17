class ChangeEnddatetoDatetime < ActiveRecord::Migration
  def change
    change_column :Assignments, :end_date,  :datetime
  end
end
