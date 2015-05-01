class AddAttachmentSnapFileToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :snap_file
    end
  end

  def self.down
    remove_attachment :projects, :snap_file
  end
end
