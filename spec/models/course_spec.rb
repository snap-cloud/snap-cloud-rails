require 'spec_helper'

describe Course do
    describe "#students" do
        before(:each) do

            @course = Course.create(title: "CS 169 - Software Engineering",
                                    description: "This is a course on engineering software.  In the spring 2015 semester, the focus will be on engineering software as a service.",
                                    website: "http://google.com",
                                    startdate: 10.days.ago,
                                    enddate: 10.days.from_now)

            @alec = User.create(email: "alec@alec.com",
                                password: "passwordhungary")
            @jason = User.create(email: "jason@jason.com",
                                password: "passwordhungary")
            @arjun = User.create(email: "arjun@arjun.com",
                                password: "passwordhungary")
            @linda = User.create(email: "linda@linda.com",
                                password: "passwordhungary")
            @steve = User.create(email: "steve@steve.com",
                                password: "passwordhungary")
            @michael = User.create(email: "michael@michael.com",
                                password: "passwordhungary")

            @course.addUser(@alec, :student)
            @course.addUser(@jason, :student)
            @course.addUser(@arjun, :student)

            @course.addUser(@linda, :teacher)
        end

        it "Should return all the students in the course" do
            SIDS = @course.students.map(&:id)
            puts SIDS
            expect(SIDS).to include @alec.id
            expect(SIDS).to include @jason.id
            expect(SIDS).to include @arjun.id
        end

        it "Should not return any students not enrolled in the course" do
            SIDS = @course.students.map(&:id)
            expect(SIDS).not_to include @steve.id
            expect(SIDS).not_to include @michael.id
        end

        it "Should not return any teachers" do
            SIDS = @course.students.map(&:id)
            expect(SIDS).not_to include @linda.id
        end
  
    end
end
