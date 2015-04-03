Feature: Creating a Course
	In order to teach a course
	As a teacher
	I want to be able to create a course

Background:
  Given the following users exist:
  | username | email | password | password_confirmation |
  | testuser | test@example.com | hello | hello |

Scenario: Creating a course while not logged in
Given I enter the course information
Then I should see that I cannot create a course

Scenario: Creating a course while logged in
Given I am logged in as testuser
And I enter the course information
Then I should see that course creation succeeded

Scenario: Deleting a course I cannot
Given there is a course I did not create
When I go to delete that course
Then I should see that I cannot delete this course

Scenario: Deleting one of my courses
Given I am logged in as testuser
And I enter the course information
When I go to delete that course
Then I should see that course deletion succeeded
