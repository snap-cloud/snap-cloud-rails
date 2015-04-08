Feature: User Dashboard Page
  In order to be productive
  As a user of Snap! 
  I would like a dashboard with my information

Background:
  Given the following users exist:
  | username | id |       email       | password | password_confirmation |
  | testuser | 1  | test@example.com  |  hello   |       hello           |

Scenario: Dashboard not visible without logging in 
  Given I am not logged in
  And I visit the home page
  Then I should see the splash page 

Scenario: Dashboard is visible upon logging in
  Given I am logged in as testuser
  And I visit the home page
  Then I should see the dashboard page 
  And I should see a news feed
  And I should see a projects listing
  And I should see a class listing 

Scenario: Users can create a project from the dashboard
  Given I am logged in as testuser
  And I visit the home page
  And I follow Create
  Then I will be on the snap page

Scenario: Users can get help from the dashboard
  Given I am logged in as testuser
  And I visit the home page
  And I follow Get Started
  Then I will be on the help page

Scenario: Users can learn more about snap from the dashboard
  Given I am logged in as testuser
  And I visit the home page
  And I follow About
  Then I will be on the about snap page

Scenario: Users can see their profile from the dashboard
  Given I am logged in as testuser
  And I visit the home page
  And I follow Profile
  Then I will be on the profile page for testuser

Scenario: Users can logout from the dashboard
  Given I am logged in as testuser
  And I visit the home page
  And I follow Logout
  Then I should be logged out


