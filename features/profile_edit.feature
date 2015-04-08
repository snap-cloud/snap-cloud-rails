Feature: User Profile Preview
  As a user of Snap!
  In order to check my profile
  I should be able to view the profile and profile edit page separately


Background:
  Given the following users exist:
  | email            | password      | username      |
  | test@example.com | hellodolly    | testuser      |
  | test@sample.com  | dollyhello    | bill          |

  And the following projects exist:
  | title   | notes        | owner | is_public |
  | ohsnap! | awesomesauce | 1     | true      |
  | snapoh! | sauceawesome | 1     | false     |
  | snapp!  | nosauce      | 2     | true      |

Scenario: View own profile when logged in
  Given I am logged in as "test@example.com" with password "hellodolly"
  And I am on the profile page for "testuser"
  Then I should see "testuser"
  And I should see "My Projects"
  And I should see "About Me"
  And I should not see "Change profile pic"
  And I should not see the submit button "Update"
  And I should see "Edit"
  Then I click "Edit"
  Then I should see the submit button "Update"
  And I should see "Change profile pic"
  And I should see "ohsnap!"
  And I should see "awesomesauce"
  And I should see "snapoh!"
  And I should see "sauceawesome"
  And I should not see "snapp!"
  And I should not see "nosauce"
  And I should see a file input
