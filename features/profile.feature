Feature: User Profile Page
  In order to share my work
  As a user of Snap!
  I would like to create a profile

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

Scenario: View profile of other user or not logged in
  Given I am on the profile page for "testuser"
  Then I should see "testuser"
  And I should see "About"
  And I should see "About Me"
  And I should see "My Projects"
  And I should not see the submit button "Update"
  And I should see "ohsnap!"
  And I should see "awesomesauce"
  And I should not see "snapoh!"
  And I should not see "sauceawesome"
  And I should not see "snapp!"
  And I should not see "nosauce"
  And I should not see a file input

Scenario: Report a user profile
  Given I am on the profile page for "testuser"
  Then I should not see an element "#edit-profile"
  And I should see an element "#report-profile"

Scenario: View own profile when logged in
  Given I am logged in as "test@example.com" with password "hellodolly"
  And I am on the profile page for "testuser"
  Then I should see "testuser"
  And I should see "My Projects"
  And I should see "About Me"
  And I should see "ohsnap!"
  And I should see "awesomesauce"
  And I should see "snapoh!"
  And I should see "sauceawesome"
  And I should not see "snapp!"
  And I should not see "nosauce"
  Then I should see an element "#edit-profile"
  And I should not see an element "#report-profile"
