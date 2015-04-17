class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :course_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
