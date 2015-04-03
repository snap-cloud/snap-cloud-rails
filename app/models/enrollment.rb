class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  #If more roles are added in the future, add them onto the end of the list!!
  enum role: [ :student, :teacher ]
  
end
