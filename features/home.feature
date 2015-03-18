Feature: Main Login Page
  In order to save my work
  As a user of Snap!
  I would like to login

Background:
  Given the following users exist:
  | username | email | password | password_confirmation |
  | testuser | test@example.com | hello | hello |

  Given I am on the home page

Scenario: View the login buttons
  Then I should see "Login"
  And I should see "Sign Up"
  And I should see "Launch Snap!"

Scenario: View the login box
  Given if I click on "Login"
  Then I should see "Username"
  And I should see "Password"
  And I should see "Submit"

Scenario: Failed login - password
  Given if I click on "Login"
  And I enter in "testuser" for username
  And I enter in "goodbye" for password
  And I click "Submit"
  Then I should see "Invalid username or password"

Scenario: Failed login - username
  Given if I click on "Login"
  And I enter in "usertest" for username
  And I enter in "hello" for password
  And I click "Submit"
  Then I should see "Invalid username or password"

Scenario: Successful login
  Given if I click on "Login"
  And I enter in "testuser" for username
  And I enter in "hello" for password
  And I click "Submit"
  Then I should be on the dashboard page
