class Course < ActiveRecord::Base
    has_many :enrollments, :dependent => :delete_all

    def addUser(person, role)
        Enrollment.create(user_id: person.id, course_id: self.id, role: role)
    end

    def removeUser(person)
        Enrollment.where(user_id: person.id, course_id: self.id).delete
    end

    def userRole(person)
    	Enrollment.find_by(user_id: person.id, course_id: self.id)
    end

    def students
        all = self.enrollments.select(&:student?).map(&:user)
        if all.any?
            return all
        else
            return nil
        end
    end
end
