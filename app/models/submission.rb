class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :project
end
