class RebuildSubmissionTable < ActiveRecord::Migration
  def change
    drop_table :submissions

    create_table :submissions do |t|
      t.string :title
      t.integer :assignment_id
      t.integer :project_id
      t.text :comments

      t.timestamps null: false
    end
  end
end
