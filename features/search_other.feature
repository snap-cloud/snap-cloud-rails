Feature: Content Search
  In order to find cool stuff,
  As a user of Snap!
  I would like to be able to search for content.

Background:
  Given the following users exist:
  | email         | password     | username |
  | test@test.com | yoloswaggins | bob	    |

  And the following projects exist:
  | title           | notes        | owner | is_public |
  | ohsnap!         | awesomesauce | 1     | true      |
  | ohsnap-private! | awesomesauce | 1     | false     |
  | lalala          | awesomesauce | 1     | true      |

Scenario: View the search box
  # App Level Template box. Make sure this exists when logged in/out.
  Given I am on the splash page
  Then I should see the text box "Search"
  Given I am on the dashboard page
  Then I should see the text box "Search"


Scenario: Search Should Return User Listings
  # This is INCREDIBLY basic and only searches by title / name.
  Given I enter a search term "bob"
  Then I should be redirected to the search results page
  Then I should see "Search Term"
  Then I should see "bob" in the "term" section
  Then I should see a checkbox to filter "Users"
  Then I should see a checkbox to filter "Projects"
  Then I should see "Results"
  Then I should see a "Users" in the "Results" section
  Then I should see a "Projects" in the "Results" section
  Then I should see "bob" in the "User Results" section
  Then I should see "No Projects Found" in the "Project Results" section


Scenario: Searching By Project Title
  # This is INCREDIBLY basic and only searches by title / name.
  Given I enter a search term "ohsnap"
  Then I should be redirected to the search results page
  Then I should see "Search Term"
  Then I should see "ohsnap" in the "term" section
  Then I should see a checkbox to filter "Users"
  Then I should see a checkbox to filter "Projects"
  Then I should see "Results"
  Then I should see a "Users" in the "Results" section
  Then I should see "No Users Found" in the "User Results" section
  Then I should see a "Projects" in the "Results" section
  Then I should see "ohsnap" in the "Project Results" section
  # DO NOT REVEAL PRIVATE PROJECTS
  Then I should not see "ohsnap-private!" in the "Project Results" section

Scenario: See my own presonal private projects.
  Given I am logged in as "test@test.com" with password "yoloswaggins"
  Given I enter a search term "ohsnap"
  Then I should be redirected to the search results page
  Then I should see "Search Term"
  Then I should see "ohsnap" in the "term" section
  Then I should see a checkbox to filter "Users"
  Then I should see a checkbox to filter "Projects"
  Then I should see "Results"
  Then I should see a "Users" in the "Results" section
  Then I should see "No Users Found" in the "User Results" section
  Then I should see a "Projects" in the "Results" section
  Then I should see "ohsnap" in the "Project Results" section
  # NOW REVEAL PRIVATE PROJECTS
  Then I should see "ohsnap-private!" in the "Project Results" section

Secnario: No Content Is Found.
  Given I enter a search term "iamnotarealuser"
  Then I should be redirected to the search results page
  Then I should see "Search Term"
  Then I should see "iamnotarealuser" in the "term" section
  Then I should see a checkbox to filter "Users"
  Then I should see a checkbox to filter "Projects"
  Then I should see "Results"
  Then I should see a "Users" in the "Results" section
  Then I should see a "Projects" in the "Results" section
  Then I should see "No Users Found" in the "User Results" section
  Then I should see "No Projects Found" in the "Project Results" section

Scenario: Search Should Flash Warnings with empty searches
  # Sad Path w/ absent query should still render the search.
  Given I am on the search results page
  # FIXME -- shouldn't this be some string in a config?
  Then I should see "Please Enter a Search Term"
  # TODO: DRY this shit out?
  Then I should see "Search Term"
  Then I should see a checkbox to filter "Users"
  Then I should see a checkbox to filter "Projects"
  Then I should see "Results"
  Then I should see a "Users" in the "Results" section
  Then I should see a "Projects" in the "Results" section