Feature: Editing a Course
	In order to know who I am teaching
	As a teacher
	I want to be able to see who is in my course

Background:
	Given a user is signed up as "test@example.com" with password "password"
	Given a user is signed up as "teacher@cal.edu" with password "password"

	Given the following courses exist:
	| id | title |
	| 1234567 | test course |

	Given the following users exist:
	| id | username | email |
	| 1 | alice | alice@cal.edu |
	| 2 | bob | bob@cal.edu |
	| 3 | charlie | charlie@cal.edu |
	| 4 | diane | doug@cal.edu |
	| 5 | emily | emily@cal.edu|

	Given the following enrollments exist:
	| user_id | course_id | role |
	| 1 | 1234567 | 1 |

Scenario: Not logged in user tries to edit
When I try to visit the edit page for "test course"
Then I should see that I need to be logged in to edit