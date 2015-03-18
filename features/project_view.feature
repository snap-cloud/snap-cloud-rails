Feature: Viewing Project Details Page
  In order to explore projects
  As a user of Snap!
  I would like to be able to see details of a project.

Background:
  Given the following projects exist:
  | title | description | owner | shared_with |  
  |  Foo  | foo foo foo | Alice |    nil      |
  |  Bar  | bar bar bar | Alice |    Bob      |
  |  Not  | not not not |  Bob  |    nil      |

  Given I am on the project details page for Foo

Scenario: View owner of project
  Then I should see Alice

Scenario: Editing the project from details
  And if I click on edit_project
  Then I will be on Foo's edit page

Scenario: Seeing shared users (collaborators)
  Given I am on the project details page for Bar
  Then I should see Alice,Bob as collaborators

Scenario: Unsharing a project
  Given I am on the project details page for Bar
  Given I am logged in as Alice
  And I unshare Foo with Bob
  Then I should not see Bob as collaborators

Scenario: Sharing a project
  Given I am on the project details page for Foo
  Given I am logged in as Alice
  And I share Foo with Bob
  Then I should see Bob as collaborators

Scenario: Running the project
  Given I am on the project details page for Foo
  And I click Play
  Then the project should run
