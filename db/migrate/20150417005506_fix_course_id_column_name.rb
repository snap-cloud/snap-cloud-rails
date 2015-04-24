class FixCourseIdColumnName < ActiveRecord::Migration
  def change
    rename_column :assignments, :course_id_id, :course_id
  end
end
