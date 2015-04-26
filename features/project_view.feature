Feature: Viewing Project Details Page
  In order to explore projects
  As a user of Snap!
  I would like to be able to see details of a project.

Background:
  Given the following users exist:
  | id | username | email         | password     |
  | 1  | test_man | test@test.com | yoloswaggins |
  | 2  | yolo_man | yolo@yolo.com | idfkmanhehe  |

  And the following projects exist:
  | id | title   | notes        | owner | is_public |
  | 1  | ohsnap! | awesomesauce | 1     | true      |
  | 2  | ohpriv! | ucantseeme   | 1     | false     |

  Given I am logged in as "test@test.com" with password "yoloswaggins"
  Given I am on the project details page for "ohsnap!"

Scenario: View title of project
  Then I should see "ohsnap!"

Scenario: View owner of project
  Then I should see "test@test.com"

Scenario: Editing the project from details as owner
  Then I press "edit_project"
  And I will be on the edit page for "ohsnap!"

Scenario: Seeing public/private level of project
  Then I should see "Public"
  And I should not see "Private"

Scenario: Seeing comments
  Then I should see "Comments"

Scenario: Seeing collaborators
  Then I should see "Collaborators"

Scenario: Report a Project
 Then I press "report_project"

Scenario: Seeing project thumbnail
  Then I should see an image

Scenario: Editing the project from details as not owner
  Given I am logged in as "yolo@yolo.com" with password "idfkmanhehe"
  Then I should not see "edit_project"

Scenario: Hide Private Project
  And I am on the project details page for "ohpriv!"
  # Note -- We are currently returning 404's for 401's due to privacy concerns.
  Then I should see "404"
