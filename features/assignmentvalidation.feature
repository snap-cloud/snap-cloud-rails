Feature: Assignment validation
    As a teacher
    So that I don't make any mistakes
    Assignments I try to create should be validated.


    Scenario: Try to edit assignment that has already ended.
        Given the assignment ending 10 days ago
        When I go to the edit page for that assignment
        And I make a change to the title
        And I click submit
        Then I should be on the edit page for that assignment
        And I should see "This assignment has already ended"

    Scenario: Try to create an assignment that has already ended.
        Given I am on the create page for an assignment
        And I fill in all the fields
        And I change the due date field to 10 days ago
        And I click submit
        Then I should be on the create page for that assignment
        And I should see "Can not create an assignment that has already ended"
    