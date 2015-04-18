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
    |id | username | email | password | password_confirmation |
    | 100 | teacher | teacher@cal.edu | password | password |
    | 200 | alice | alice@cal.edu | password | password |
    | 300 | beatrice | beatrice@cal.edu | password | password |

    Given the following assignments exist:
    | id | title | description | course_id | start_date | due_date |
    | 100 | assign1 | "description for #1" | 234 | 1.day.ago | Date.current.advance(days: 3) |
    | 200 | assign2 | "description for #2" | 234 | 2.day.ago | 5.minute.ago |
    | 300 | assign3 | "description for #3" | 234 | 3.day.ago | 3.hour.ago |

    Given the following projects exist:
    | title | owner |
    | aliceproj1 | 200 |
    | aliceproj2 | 200 |
    | aliceproj3 | 200 |
    | beatriceproj1 | 300 |
    | beatriceproj2 | 300 |
    | beatriceproj3 | 300 |

    Given the following submissions exist:
    | title | assignment_id | 
    | submittedproj1 | 100 |
    | submittedproj2 | 100 |

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

Scenario: Teacher tries to delete assignment
    Given I am logged in as "teacher@cal.edu" with password "password"
    And I visit the assignment show page for "assign1"
    And I click delete assignment
    Then I should see that I deleted the assignment

Scenario: Teacher views assignments for a class
    Given I am logged in as "teacher@cal.edu" with password "password"
    Then I should see all the assignments for "assignmentcourse"

Scenario: Student views assignments for a class
    Given I am logged in as "beatrice@cal.edu" with password "password"
    Then I should see all the assignments for "assignmentcourse"

# end of features for just assignments

Scenario: Student submits project to an assignment from a course they are a part of
    Given I am logged in as "beatrice@cal.edu" with password "password"
    When I try to visit the page for "assignmentcourse"
    And I click on assignment "assign1"
    And I select "aliceproj1" to submit
    Then I should see that my submission was successful

Scenario: Teacher views submissions for an assignment
    Given I am logged in as "teacher@cal.edu" with password "password"
    When I try to visit the page for "assignmentcourse"
    And I click on assignment "assign1"
    And I should see all of the submissions "assign1"

Scenario: Student submits project to an assignment from a course they are not a part of
    Given I am logged in as "alice@cal.edu" with password "password"
    When I visit the assignment show page for "assign1"
    Then I should see that I do not have permission to submit an assignment

Scenario: Submitting late assignments
    Given I am logged in as "beatrice@cal.edu" with password "password"
    And I visit the assignment show page for "assign1"
    Then I should not be able to submit a project to it