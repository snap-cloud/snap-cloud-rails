class Project < ActiveRecord::Migration
  create_table(:projects) do |t|

    t.string  :title
    t.text    :notes
    t.binary  :thumbnail
    t.text    :contents
    t.boolean :is_public
    t.integer :owner
    t.timestamp :last_modified

    t.timestamps
  end
end
