Feature: Saving Loading Projects
  In order to be productive
  As a user of Snap!
  I would like to save and load my projects.

Background:
  Given I have the following projects:
  | title | owner | # project_id | date_created | last_modified | 


Scenario: View a list of projects
  Given I am logged in
  When I click Projects
  Then I will see all my projects

Scenario: Open a new project
  Given I am on the list of projects
  When I click the New buttion
  Then a new project should be open

Scenario: Save a new project
  Given I have a project open
  When I click the Save button
  Then the project will be created
  And the project will be saved
  And my list of projects should be updated with the new project

Scenario: Open an existing project
  Given I am on the list of projects
  And I have at least one project
  When I click the Open button of a project
  Then the project should be open

Scenario: Save an existing project
  Given I have a project open
  When I click the save button
  And the project will be saved