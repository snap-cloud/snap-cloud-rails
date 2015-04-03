class Course < ActiveRecord::Base
    has_many :enrollments
end
