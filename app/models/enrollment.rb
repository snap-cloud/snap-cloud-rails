class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  enum role: [ :student, :teacher ]
  
end
