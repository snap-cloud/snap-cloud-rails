Feature: Project Submission
    As a student
    So that I can complete assignments
    I should be able to submit projects for an assignment

    As a teacher
    So that I can grade students
    I should be able to see projects they've submitted

Background:

    Given the following courses exist:
    | id | title |
    | 1234567 | testcourse |
    | 234 | assignmentcourse |

    Given the following users exist:
    | username | email | password | password_confirmation |
    | teacher | teacher@cal.edu | password | password |
    | alice | alice@cal.edu | password | password |
    | beatrice | beatrice@cal.edu | password | password |

    Given the following assignments exist:
    | title | description | course_id | start_date | due_date |
    | assign1 | "description for #1" | 234 | 1.day.ago | 1.hour.ago |
    | assign2 | "description for #2" | 234 | 2.day.ago | 2.hour.ago |
    | assign3 | "description for #3" | 234 | 3.day.ago | 3.hour.ago |

    Given user "teacher@cal.edu" is enrolled as a teacher in "testcourse"
    Given user "teacher@cal.edu" is enrolled as a teacher in "assignmentcourse"
    Given user "alice@cal.edu" is enrolled as a student in "testcourse"
    Given user "beatrice@cal.edu" is enrolled as a student in "assignmentcourse"

Scenario: Not logged in user tries to access assignment
    When I visit the assignment show page for "assign1"
    Then I should see that I need to log in

Scenario: Teacher creates assignment
    Given I am logged in as "teacher@cal.edu" with password "password"
    When I try to visit the page for "testcourse"
    And I click the create assignment button
    And I fill in everything to create a new assignment
    Then I should see that I created an assignment

Scenario: Teacher edits assignment
    Given I am logged in as "teacher@cal.edu" with password "password"
    And I visit the assignment show page for "assign1"
    And I click edit assignment
    And I change title to "Thisisthenewtitle"
    Then I should see that I edited this assignment
    And I should see "Thisisthenewtitle"

Scenario: Teacher views assignments for a class
    Given I am logged in as "teacher@cal.edu" with password "password"
    Then I should see all the assignments for "assignmentcourse"

Scenario: Student views assignments for a class
    Given I am logged in as "beatrice@cal.edu" with password "password"
    Then I should see all the assignments for "assignmentcourse"

# end of features for just assignments

Scenario: Student submits project to an assignment from a course they are a part of
    Givens some assignments, projects I own, and a course i'm part of
    When I go to course page
    And I click some assignment
    Then I should be on the show assignment page
    Then I should be on the submission page
    And I change the dropdown to pick the project I want to submit
    And click submit

Scenario: Teacher views submissions for an assignment
    Given everything this needs
    When I go to the course page
    And pick an assignment
    Then I should be on the assignment view page
    And I should see all of the submissions for that assignment

Scenario: Student submits project to an assignment from a course they are not a part of
    Given everything this needs
    When I try to visit the submission page for an assignment
    Then I should be redirected to 401

Scenario: Submitting late assignments
    Given everything this needs
    When I am on the show assignment page
    And the assignment has ended
    Then I should not be able to submit a project to it