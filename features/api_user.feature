Feature: User Accounts
  In order to save my projects
  As a programmer
  I want to sign up for a Snap! account.
  
  Scenario: Signing Up
    Given I have entered a username
    And I have entered in a birthday
    And I have agreed to the ToS
    When I click Signup
    Then an account will be created for me
    
  Scenario: Log In
    Given I can see the login screen
    And I have entered in my username
    And I have entered in my password
    When I click log in
    Then I will be logged in.
    
    x