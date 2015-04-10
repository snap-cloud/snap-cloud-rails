Feature: Viewing Project Details Page
  In order to explore projects
  As a user of Snap!
  I would like to be able to see details of a project.

Background:
  Given the following users exist:
  | id | email         | password     |
  | 1  | test@test.com | yoloswaggins |

  And the following projects exist:
  | id | title   | notes        | owner | is_public |
  | 1  | ohsnap! | awesomesauce | 1     | true      |

  Given I am on the project details page for "ohsnap!"

Scenario: View title of project
  Then I should see "ohsnap!"

Scenario: View owner of project
  Then I should see "test@test.com"

Scenario: Editing the project from details
  Then I follow "edit_project"
  And I will be on the edit page for "ohsnap!"

Scenario: Seeing public/private level of project
  Then I should see "Public"
  And I should not see "Private"

Scenario: Seeing comments
  Then I should see "Comments"

Scenario: Seeing collaborators
  Then I should see "Collaborators"

Scenario: Running the project
  Given I am on the project details page for "ohsnap!"
  Then I should see "Try It!"

Scenario: Report a Project
 Then I should see "Mark as Inappropriate"

Scenario: Seeing project thumbnail
  Then I should see the thumbnail for "ohsnap!"
