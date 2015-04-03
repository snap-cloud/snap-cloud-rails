Feature: Snap! Cloud Classes
  In order to make assignments easier
  As a teacher using Snap!
  I would like  create and manage my class.

Background:
  Given I am logged in as Alice

  And the following users exist:
  | email          | password     |
  | test@test.com  | yoloswaggins |

  And the following projects exist:
  | title | notes       | owner | is_public |
  | Foo   | foo foo foo | 1     | true      |
  | Bar   | new new new | 2     | false     |

  Given I am on the project listing page

Scenario: Dashboard view--the list of projects
  Then I should see Foo, Bar
  And I should not see Not

Scenario: Viewing an existing Project
  And if I click on Foo
  Then I will be on Foo's edit page

Scenario: New project
  Given I create a project FooBar
  Then FooBar should be created
  Then I should be on Foobar's edit page

Scenario: Editing an existing project
  Given if I click on Foo
  Then I will be on Foo's edit page
  And if I edit Foo's description to "new new new"
  And save my changes to Foo
  Then Foo's description should be "new new new"

Scenario: Sharing and unsharing a project
  Given I click on Foo
  Then I will be on Foo's edit page
  And I share Foo with Bob
  When that I log out
  And I log in as Bob
  Then I should see Foo

Scenario: Unsharing a project
  Given I click on Bar
  Then I will be on Bar's edit page
  And I unshare Bar with Bob
  When I log out
  And I log in as Bob
  Then I should not see Bar


