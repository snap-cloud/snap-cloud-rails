class AddCommentsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :comments, :text
  end
end
