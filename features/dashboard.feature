Feature: User Dashboard Page
  In order to be productive
  As a user of Snap! 
  I would like a dashboard with my information

Background:
  Given the following users exist:
  | username |      email       | password | password_confirmation |
  | testuser | test@example.com |  hello   |       hello           |

  And the following projects exist:
  | title   | notes        | owner | is_public |
  | ohsnap! | awesomesauce | 1     | true      |

  Given I am on the splash page

Scenario: View the Dashboard upon logging in
  Then I should see the link "Sign In" to "/login"
  Then I should see the link "Sign Up" to "/signup"
  Then I should see "snap-logo.png"
  Then I should see the link "Create" to "/snap/"
  And I should see the link "Get Started" to "/help"
  And I should see the link "About" to "/about"

Scenario: Dashboard lets the user run Snap! 
  And I should see "Run"
  And I should see "Now"
  And I should see "WELCOME TO SNAP!"
  And I should see "half-snapshot.png"

Scenario: Dashboard informs user of announcements
  And I should see "Featured Projects"
  And I should see "ohsnap!"
  And I should see "awesomesauce"
  And I should see "bob"

Scenario: Dashboard shows all of user's projects 
  Given I am logged in as "test@test.com" with password "yoloswaggins"
  Then I should see "Profile"
  And I should see "Logout"
  And I should not see "Sign Up"
  And I should not see "Sign In"

