class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :submissions
  has_many :projects, through: :submissions

  #Currently downloads the snap file from S3 and reuploads it attached to sumbission
  def submit(project_id, comments)
  	proj = Project.find(project_id)
  	subCopy = proj.dup
  	subCopy.last_modified = Time.now
  	subCopy.read_only = true
    subCopy.submitted = true
    subCopy.title += " --Submitted: #{Time.now}--"
    subCopy.snap_file = proj.snap_file
  	subCopy.save
  	Submission.create(assignment_id: self.id, comments: comments, project_id: subCopy.id)
  end
end
