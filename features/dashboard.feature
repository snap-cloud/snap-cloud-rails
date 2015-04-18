Feature: User Dashboard Page
  In order to be productive
  As a user of Snap! 
  I would like a dashboard with my information

Background:
  Given the following users exist:
  | id | username|       email      | password      | password_confirmation |
  | 1  | linda   | linda@linda.com  |  lindalinda   |       lindalinda      |

  And the following announcements exist: 
  | id | source |  text |   time   | 
  | 1  | cs169  | 'foo' | today    | 
  | 2  | snap!  | 'bar' | yesterday|

  And the following projects exist:
  | id |     title    | notes | owner | is_public |
  | 1  | lindas-proj1 | proj1 | 1     | true      |
  | 2  | lindas-proj2 | proj2 | 1     | false     |

  And the following courses exist:
  | id | title   | description  |    website   | updated_at | enddate | 
  | 1  | cs169   | learn ruby!  | www.cs169.com| today      | tomorrow| 

  And the following assignments exist:
  | id | title   |     description      | course_id | start_date | due_date   |
  | 1  | assign1 | "description for #1" |     1     | 1.day.ago  | 1.hour.ago |

Given I am logged in as "linda@linda.com" with password "lindalinda"
Given user "linda@linda.com" is enrolled as a student in "cs169"
Given I am on the home page

Scenario: Dashboard is visible upon logging in
  Then I can see the dashboard 

Scenario: Dashboard not visible without logging in 
  Given I log out 
  And I am on the home page
  Then I should see the splash page 

Scenario: Run Snap from the Dashboard
  Given I can see the dashboard
  And I press RunSnap
  Then I am on the snap page

Scenario: Newsfeed
  Given I can see the dashboard
  Then I should see "News Feed"
  And I should see my announcements

Scenario: Assignments
  Given I can see the dashboard
  Then I should see "Your Assignments"
  And I should see my assignments

Scenario: Courses
  Given I can see the dashboard
  Then I should see "Your Courses"
  And I should see my courses

Scenario: Projects
  Given I can see the dashboard
  Then I should see "Your Projects"
  And I should see my projects

Scenario: Side Navbar 
  Given I can see the dashboard
  Then I should see "Navigation"
  And I should see navigation links



