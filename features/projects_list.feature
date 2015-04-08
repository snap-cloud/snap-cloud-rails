Feature: User Dashboard Page
  In order to save time and be organized
  As a user of Snap! 
  I would like a project list with my projects on my dashboard

Background:
  Given the following users exist:
  | username | id |       email       | password | password_confirmation |
  | testuser | 1  | test@example.com  |  hello   |       hello           |

  And the following projects exist:
  | title  |   notes      | owner | is_public | created_on | class | 
  | foo    | description0 |   1   |   true    |    3:00    | cs169 |
  | bar    | description1 |   1   |   false   |    2:00    | cs169 | 
  | baz    | description2 |   1   |   true    |    1:00    | cs170 |

  Given I am logged in as testuser
  And I visit the home page

Scenario: See all projects 
  Given I am on the dashboard 
  I should see foo, bar, baz

Scenario: Sort projects by title
  Given I am on the dashboard
  And I follow "Sort Projects by Title"
  Then I should see bar, then baz, then foo

Scenario: Sort projects by date
  Given I am on the dashboard
  And I follow "Sort Projects by Date"
  Then I should see baz, then bar, then foo

Scenario: Filter projects by class 
  Given I am on the dashboard
  And I filter by "cs169"
  Then I should see foo, bar
  And I should not see foo 

Scenario: Filter projects by public/private
  Given I am on the dashboard
  And I filter by "private"
  Then I should see bar
  And I should not see foo, baz