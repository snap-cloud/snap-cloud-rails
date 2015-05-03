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

Scenario: View others profile edit page
  Given I am on the profile edit page for "testuser"
  Then I should see "404"

Scenario: View own profile edit page and submit
  Given I am logged in as "test@example.com" with password "hellodolly"
  And I am on the profile page for "testuser"
  Then I should see "testuser"
  And I should see "My Projects"
  And I should see "About Me"
  And I should not see the submit button "Update"
  And I press "edit-profile"
  Then I will be on the edit page for user 1
  And I should see the submit button "Update"
  And I should see a file input
  And I enter "About testuser" for "user_about_me"
  And I press "Update"
  Then I will be on the profile page for user 1
