Feature: Sorting, Filtering Projects
  In order to be productive
  As a user of Snap!
  I would like to filter and sort my projects.

Background:
  Given I am logged in as Alice

  And the following projects exist:
  | title | description | owner | shared_with |    date    |  public | class |
  |  Foo  | foo foo foo | Alice |    nil      | 1427833194 |    0    | cs167 | 
  |  Bar  | bar bar bar | Alice |    nil      | 1427833193 |    1    | cs169 |
  |  Not  | not not not | Alice |    nil      | 1427833192 |    1    | cs168 |

  Given I am on the list of projects page

Scenario: Sort by Title, alphabetically 
  Given I sort by Title
  Then I should see Bar, Foo, Not

Scenario: Sort by Date, showing most recent first 
  Given I sort by Date
  Then I should see Foo, Bar, Not

Scenario: Sort by Class, alphabetically
  Given I sort by class
  I should see Foo, Not, Bar

Scenario: Filter by Public or Private
  Given if I click Public
  Then I should see Bar, Not
  And if I click on Private
  Then I should see Foo


