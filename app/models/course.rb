class Course < ActiveRecord::Base
    has_many :enrollments

    def addUser(person, role)
        Enrollment.create(user_id: person.id, course_id: self.id, role: role)
    end

    def removeUser(person)
        Enrollment.where(user_id: person.id, course_id: self.id).delete
    end
end
