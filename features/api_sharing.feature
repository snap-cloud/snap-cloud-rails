Feature: Sharing Projects
  In order to collaborate
  As a user of Snap!
  I would like to share my projects with others

Background:
  Given I have the following projects:
  | title | owner | # project_id | date_created | last_modified | 

Scenario: Sharing
  Given I am logged in
  And I open "thisproject"
  And I share "thisproject" with "myfriend"
  Then "myfriend" should be able to view and edit "thisproject"

Scenario: Unsharing
  Given I am logged in
  And I shared "thisproject" with "myfriend"
  When I unshare "thisproject" with "myfriend"
  Then "myfriend" should not be able to view or edit "thisproject"

Scenario: Viewing a shared Project (not logged in)
  Given I am not logged in
  When I try to view a private project "privateproject"
  Then I should see "You are not logged in"
