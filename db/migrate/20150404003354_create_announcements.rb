class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :source
      t.integer :source_id
      t.string :to_whom
      t.text :text
      t.datetime :time

      t.timestamps null: false
    end
  end
end
