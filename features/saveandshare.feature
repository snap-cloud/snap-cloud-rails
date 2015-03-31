Feature: User Dashboard
  In order to be productive
  As a user of Snap!
  I would like to save and load my projects.

Background:
  Given I am logged in as Alice

  And the following projects exist:
  | title | description | owner | shared_with |  
  |  Foo  | foo foo foo | Alice |    nil      |
  |  Bar  | bar bar bar | Alice |    Bob      |
  |  Not  | not not not |  Bob  |    nil      |

  Given I am on the list of projects page

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


