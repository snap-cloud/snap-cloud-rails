Feature: User Accounts
  In order to save my projects
  As a programmer
  I want to sign up for a Snap! account.
  
Scenario: Signing Up
  Given I am on the signup page
  And I enter in signup information
  And my signup submission is valid
  Then an account will be created
    
Scenario: Log In
  Given I am on the login page
  And I enter in my password and username
  And my username and password are valid
  Then I will be logged in
