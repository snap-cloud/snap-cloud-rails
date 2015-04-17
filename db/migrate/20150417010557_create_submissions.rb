class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
        t.string   "title"
        t.text     "notes"
        t.binary   "thumbnail"
        t.text     "contents"
        t.boolean  "is_public"
        t.integer  "owner"
        t.datetime "last_modified"
        t.datetime "created_at"
        t.datetime "updated_at"
    end
  end






end
