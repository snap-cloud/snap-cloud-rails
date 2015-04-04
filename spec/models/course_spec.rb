require 'spec_helper'

describe Course do
    describe "#students" do
        before(:each) do

            @course = Course.new(title: "CS 169 - Software Engineering", description: "This is a course on engineering software.  In the spring 2015 semester, the focus will be on engineering software as a service.", website: "http://google.com", startdate: 10.days.ago, enddate: 10.days.from_now)


            @alec = User.create(email: "alec@alec.com", password: "alec")
            @jason = User.create(email: "jason@jason.com", password: "jason")
            @arjun = User.create(email: "arjun@arjun.com", password: "arjun")
            @linda = User.create(email: "linda@linda.com", password: "linda")
            @steve = User.create(email: "steve@steve.com", password: "steve")
            @michael = User.create(email: "michael@michael.com", password: "michael")

            @course.addUser(@alec, :student)
            @course.addUser(@jason, :student)
            @course.addUser(@arjun, :student)

            @course.addUser(@linda, :teacher)
            
        end

        it "Should return all the students in the course" do
            
        end

        it "Should not return any students not enrolled in the course" do
        end

        it "Should not return any teachers" do
        end
  
    end
end
