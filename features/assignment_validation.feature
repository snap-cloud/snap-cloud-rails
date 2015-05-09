Feature: Assignment validation
    As a teacher
    So that I dont make any mistakes
    Assignments I try to create should be validated.


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
    | title | owner | thumbnail | contents |
    | aliceproj1 | 200 | 'none' | "none" |
    | aliceproj2 | 200 | 'none' | "none" |
    | aliceproj3 | 200 | 'none' | "none" |
    | beatriceproj1 | 300 | 'none' | "none" |
    | beatriceproj2 | 300 | 'none' | "none" |
    | beatriceproj3 | 300 | 'none' | "none" |

    Given user "teacher" is enrolled as a teacher in "testcourse"
    Given user "teacher" is enrolled as a teacher in "assignmentcourse"
    Given user "alice" is enrolled as a student in "testcourse"
    Given user "beatrice" is enrolled as a student in "assignmentcourse"
    Given user "beatrice" with password "password" submits "beatriceproj1" and "beatriceproj2" to "assign1"

    Scenario: Try to create an assignment that has already ended.
        Given I am logged in as "teacher" with password "password"
        When I try to visit the page for "testcourse"
        And I click the create assignment button
        And I fill in assignment due_date as late
        And I fill in everything to create a new assignment
        Then I should see that I can't create assignments due in the past

    Scenario: Try to edit assignment that has already ended.
        Given I am logged in as "teacher" with password "password"
        And I visit the assignment show page for "assign3"
        Then I should not see button for "Edit Assignment"
        And I should see that I can't edit the assignment

    Scenario: Try to create assignment with fields missing
        Given I am logged in as "teacher" with password "password"
        When I try to visit the page for "testcourse"
        And I click the create assignment button
        And I click the save button
        Then I should see the title field can't be blank
        And I should see the description field can't be blank


    Scenario: Try to edit assignment with fields missing
        Given I am logged in as "teacher" with password "password"
        And I visit the assignment show page for "assign1"
        And I click edit assignment
        And I clear the "assignment_title" textbox
        And I clear the "assignment_description" textbox
        And I click the save button
        Then I should see the title field can't be blank
        And I should see the description field can't be blank