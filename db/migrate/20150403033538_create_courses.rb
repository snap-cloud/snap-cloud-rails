class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :title
      t.text :description
      t.date :startdate
      t.date :enddate
      t.text :website

      t.timestamps null: false
    end
  end
end
