class AddCommentsToSubmissions < ActiveRecord::Migration
  def change
    add_column :Submissions, :comments, :text
  end
end
