class RemoveTitleFromSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :title
  end
end
