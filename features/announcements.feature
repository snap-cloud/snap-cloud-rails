Feature: User Dashboard Page
  In order to be see relevant information and save time
  As a user of Snap! 
  I would like to see announcements only relevant to me

Background:
  Given the following users exist:
  | username | id |       email       | password | password_confirmation |
  | testuser | 1  | test@example.com  |  hello   |       hello           |

  And the following announcements exist: 
  | source   |   text   | time |
  |  snap    |  hello   | 1:00 |
  | cs-169   |  hw5 up  | 3:00 |
  | otheruser| good job!| 2:00 |

  Given I am logged in as testuser
  And I visit the home page

Scenario: See all announcements 
  Given I am on the dashboard
  Then I should see "hello", "hw5 up", "good job!"

Scenario: Sort announcements by time
  Given I am on the dashboard
  And I follow "Sort Announcements by Date"
  Then I should see "hello", then "hw5 up", then "good job!"

Scenario: Filter announcements by source
  Given I am on the dashboard
  And I filter by "snap"
  Then I should see "hello"
  And I should not see "hw5 up", "good job!"