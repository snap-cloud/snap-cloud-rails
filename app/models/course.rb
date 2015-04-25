class Course < ActiveRecord::Base
    has_many :enrollments, :dependent => :delete_all
    has_many :users, through: :enrollments

    has_many :teacher_enrollments, -> {Enrollment.teacher}, class_name: "Enrollment"
    has_many :teachers, through: :teacher_enrollments, class_name: 'User', source: 'user'

    has_many :student_enrollments, -> {Enrollment.student}, class_name: "Enrollment"
    has_many :students, through: :student_enrollments, class_name: 'User', source: 'user'

    has_many :assignments

    def addUser(person, role)
        Enrollment.create(user_id: person.id, course_id: self.id, role: role)
    end

    def removeUser(person)
        Enrollment.find_by(user_id: person.id, course_id: self.id).delete
    end

    def userRole(person)
    	Enrollment.find_by(user_id: person.try(:id), course_id: self.id) 
    end

end
