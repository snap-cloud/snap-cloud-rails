Feature: Main Login Page
  In order to save my work
  As a user of Snap!
  I would like to login

Background:
  Given the following users exist:
  | email         | password     | username |
  | test@test.com | yoloswaggins | testuser |

  And the following projects exist:
  | title   | notes        | owner | is_public |
  | ohsnap! | awesomesauce | 1     | true      |

  Given I am on the splash page

Scenario: View the header buttons
  Then I should see the link "Sign In" to "/login"
  Then I should see the link "Sign Up" to "/signup"
  And I should see an image
  Then I should see the link "Create" to "/snap"
  And I should see the link "Get Started" to "/help"
  And I should see the link "About" to "/about"

Scenario: View the splash page main frame content
  And I should see "Run"
  And I should see "Now"
  And I should see "Welcome to snap"
  And I should see an image

Scenario: View the projects
  And I should see "Featured Projects"
  And I should see "ohsnap!"
  And I should see "awesomesauce"

Scenario: View the header buttons when logged in
  Given I am logged in as "testuser" with password "yoloswaggins"
  Given I am on the splash page
  Then I should see "Profile"
  And I should see "Logout"
  And I should not see "Sign Up"
  And I should not see "Sign In"

