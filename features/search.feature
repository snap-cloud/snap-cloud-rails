Feature: Search Users and Projects
  As a user of Snap!
  In order to find people and projects
  I would like to be able to search for people and projects

Background:
  Given the following users exist:
  | email         | password     | username |
  | test@test.com | yoloswaggins | bob	    |
  | tes@tes.com   | yoloswaggins | alec     |

  And the following projects exist:
  | title   | notes          | owner | is_public |
  | ohsnap! | awesomesauce   | 1     | true      |
  | blah    | this is a game | 1     | true      |
  | hmmmmm  | another game   | 2     | false     |

  Given I am logged in as "test@test.com" with password "yoloswaggins"

Scenario: Search for a user and their projects
  Given I can see the dashboard
  And I enter "bob" for "q_title_or_notes_or_user_username_cont"
  And I press "Search"
  Then I will be on the search page
  And I should see "bob"
  And I should see "ohsnap!"
  And I should see "blah"
  And I should not see "hmmmmm"
  And I should not see "bill"

Scenario: Search for projects by name
  Given I can see the dashboard
  And I enter "blah" for "q_title_or_notes_or_user_username_cont"
  And I press "Search"
  Then I will be on the search page
  And I should see "blah"
  And I should not see "hmmmmm"
  And I should not see "ohsnap!"

Scenario: Search for projects by notes
  Given I can see the dashboard
  And I enter "game" for "q_title_or_notes_or_user_username_cont"
  And I press "Search"
  Then I will be on the search page
  And I should see "blah"
  And I should not see "ohsnap!"
  And I should see "hmmmmm"
  Then I press "Project Title"
  And I should first see "blah" before "hmmmmm"
  Then I press "Project Notes"
  And I should first see "hmmmmm" before "blah"
  Then I press "User"
  And I should first see "hmmmmm" before "blah"
