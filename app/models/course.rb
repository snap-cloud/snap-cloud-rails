class Course < ActiveRecord::Base
    has_many :enrollments, :dependent => :delete_all

    def addUser(person, role)
        Enrollment.create(user_id: person.id, course_id: self.id, role: role)
    end

    def removeUser(person)
        Enrollment.where(user_id: person.id, course_id: self.id).delete
    end

    def userRole(person)
    	Enrollment.where(user_id: person.id, course_id: self.id).role
    end

    def students
        self.enrollments.select(&:student?).map(&:user)
    end
end
