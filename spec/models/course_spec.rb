require 'rails_helper' 

describe Course do
    describe "#students" do
        before(:each) do

            @course = Course.create(title: "CS 169 - Software Engineering",
                                    description: "This is a course on engineering software.  In the spring 2015 semester, the focus will be on engineering software as a service.",
                                    website: "http://google.com",
                                    startdate: 10.days.ago,
                                    enddate: 10.days.from_now)

            @alec = User.create( username: "alec",
                                email: "alec@alec.com",
                                password: "passwordhungary")
            @jason = User.create( username: "jason",
                                email: "jason@jason.com",
                                password: "passwordhungary")
            @arjun = User.create( username: "arjun",
                                email: "arjun@arjun.com",
                                password: "passwordhungary")
            @linda = User.create( username: "linda",
                                email: "linda@linda.com",
                                password: "passwordhungary")
            @steve = User.create( username: "steve",
                                email: "steve@steve.com",
                                password: "passwordhungary")
            @michael = User.create( username: "michael",
                                email: "michael@michael.com",
                                password: "passwordhungary")

            @course.addUser(@alec, :student)
            @course.addUser(@jason, :student)
            @course.addUser(@arjun, :student)

            @course.addUser(@linda, :teacher)
        end

        it "Should return all the students in the course" do
            all_students = @course.students.map { |s| s.id }
            
            expect(all_students).to include @alec.id
            expect(all_students).to include @jason.id
            expect(all_students).to include @arjun.id
        end

        it "Should not return any students not enrolled in the course" do
            enrolled = @course.students.map(&:id)
            expect(enrolled).not_to include @steve.id
            expect(enrolled).not_to include @michael.id
        end

        it "Should not return any teachers" do
            SIDS = @course.students.map(&:id)
            expect(SIDS).not_to include @linda.id
        end
  
    end
end
