Feature: Project Submission
    As a user
    So that it's easier to complete assignments
    I should be able to submit assignments to a class

    Scenario: Student submits project to an assignment from a course they are a part of
        Givens some assignments, projects I own, and a course i'm part of
        When I go to course page
        And I click some assignment
        Then I should be on the submission page
        And I change the dropdown to pick the project I want to submit
        And click submit

    Scenario: Teacher views submissions for an assignment
        Given everything this needs
        When I go to the course page
        And pick an assignment
        Then I should be on the assignment view page
        And I should see all of the submissions for that assignment

    Scenario: Teacher creates assignment
        Given everything this needs
        And I am on the course view page
        And I click the create assignment button
        Then I should be on the new assignment page
        And I fill in everything
        And click create
        Then I should be on the show page for that assignment

    Scenario: Teacher edits assignment
        Given everything this needs
        And I am visit the show page for that assignment
        And I click edit
        Then I should be on the assignment edit page
        I should see some stuff from that assignment
        And I change title to "blah"
        Then I click save
        Then I should beon the assignment show page for that assignment
        And I should see "blah"

    Scenario: Teacher views assignments for a class
        Given everything this needs
        And I am on the course show page
        Then I should see all the assignments in my given

    Scenario: Student views assignments for a class
        Given everything this needs
        And I am on the course show page
        Then I should see all assignments in my given

    Scenario: Student submits project to an assignment from a course they are not a part of
        Given everything this needs
        When I try to visit the submission page for an assignment
        Then I should be redirected to 401
