Feature: User Profile Page
  In order to share my work
  As a user of Snap!
  I would like to create a profile

Background:
  Given the following users exist:
  | username | email | password | password_confirmation |
  | testuser | test@example.com | hello | hello |

Scenario: View profile of other user or not logged in
  Given I am on the profile page for testuser
  Then I should see "testuser"
  And I should see "My Projects"
  And I should see "About Me"
  And I should not see "edit"

Scenario: View own profile when logged in
  Given I am logged in as testuser
  And I am on the profile page for testuser
  Then I should see "testuser"
  And I should see "My Projects"
  And I should see "About Me"
  And I should see "edit"

Scenario: Edit profile information
  Given I am logged in as testuser
  And I am on the profile page for testuser
  And I click "edit"
  Then I should see "Submit"