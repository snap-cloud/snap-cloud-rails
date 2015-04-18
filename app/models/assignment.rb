class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :submissions
  has_many :projects, through: :submissions

  def submit(project_id, comments)
  	proj = Project.find(project_id)
  	subCopy = proj.dup
  	subCopy.last_modified = proj.last_modified
  	subCopy.read_only = true
  	subCopy.save
  	Submission.create(title: subCopy.title, assignment_id: assignment_id, comments: comments, project_id: subCopy.id)
  end
end
