Feature: Login via username or email
  As a user of Snap!
  In order to view my account
  I should be able to login with either my username or email
  And I should see know if login was unsuccessful

Background:
  Given the following users exist:
  | email            | password      | username      |
  | test@example.com | hellodolly    | testuser      |
  | test@sample.com  | dollyhello    | bill          |


Scenario: Login with email
  Given I am on the login page
  And I enter "test@example.com" for "email"
  And I enter "hellodolly" for "password"
  And I click "Login"
  Then I should be on the home page

Scenario: Login with username
  Given I am on the login page
  And I enter "testuser" for "email"
  And I enter "hellodolly" for "password"
  And I click "Login"
  Then I should be on the home page

Scenario: Incorrect login with email
  Given I am on the login page
  And I enter "testusers" for "email"
  And I enter "hellodolly" for "password"
  And I click "Login"
  Then I should see "Incorrect username/email or password"

Scenario: Incorrect login with password
  Given I am on the login page
  And I enter "testuser" for "email"
  And I enter "hellodloly" for "password"
  And I click "Login"
  Then I should see "Incorrect username/email or password"
