Feature: Creating a Course
	In order to teach a course
	As a teacher
	I want to be able to create a course

Background:
  Given a user is signed up as "test@example.com" with password "hellohello"

Scenario: Creating a course while not logged in
Given I visit the new course page
Then I should see that I cannot create a course

Scenario: Deleting a course I cannot while not logged in
Given there is a course I did not create
When I go to delete that course
Then I should see that I need to log in to delete this course

Scenario: Deleting a course I cannot
Given I am logged in as "test@example.com" with password "hellohello"
Given there is a course I did not create
When I go to delete that course
Then I should see that I cannot delete this course

Scenario: Creating a course while logged in
Given I am logged in as "test@example.com" with password "hellohello"
And I visit the new course page
And I enter the course information
Then I should see that course creation succeeded

Scenario: Deleting one of my courses
Given I am logged in as "test@example.com" with password "hellohello"
Given I visit the new course page
And I enter the course information
When I go to delete that course
Then I should see that course deletion succeeded
