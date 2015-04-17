class FixCourseIdColumnName < ActiveRecord::Migration
  def change
    rename_column :Assignments, :course_id_id, :course_id
  end
end
