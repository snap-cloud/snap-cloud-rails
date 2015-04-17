Feature: Login via username or email
  As a user of Snap!
  In order to view my account
  I should be able to login with either my username or email

Background:
  Given the following users exist:
  | email            | password      | username      |
  | test@example.com | hellodolly    | testuser      |
  | test@sample.com  | dollyhello    | bill          |

Scenario: Login with email
  Given I am on the login page
  And I enter "test@example.com" for "user_login"
  And I enter "hellodolly" for "user_password"
  And I press "Log in"
  Then I will be on the home page

Scenario: Login with username
  Given I am on the login page
  And I enter "testuser" for "user_login"
  And I enter "hellodolly" for "user_password"
  And I press "Log in"
  Then I will be on the home page

Scenario: Invalid login with email
  Given I am on the login page
  And I enter "testusers" for "user_login"
  And I enter "hellodolly" for "user_password"
  And I press "Log in"
  Then I should see "Invalid username/email or password"

Scenario: Invalid login with password
  Given I am on the login page
  And I enter "testuser" for "user_login"
  And I enter "hellodloly" for "user_password"
  And I press "Log in"
  Then I should see "Invalid username/email or password"
