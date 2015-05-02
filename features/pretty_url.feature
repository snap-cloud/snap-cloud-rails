Feature: Project Submission
    As a student
    So that I can complete assignments
    I should be able to submit projects for an assignment

    As a teacher
    So that I can grade students
    I should be able to see projects they've submitted

Background:

    Given the following users exist:
    |id | username | email | password | password_confirmation |
    | 300 | beatrice | beatrice@cal.edu | password | password |

Scenario: Browse to the pretty url
    When I go to the url "/@/beatrice"
    Then I should be on the profile page of "beatrice"