Feature: Editing a Project
	As a project owner
	So that I can keep my project info as updated as possible
	I want to be able to edit projects that I own

Background:

	Given the following users exist:
	| id | username | email         | password | password_confirmation |
	| 1  | alice   | alice@cal.edu  | password | password |
	| 2  | bob     | bob@cal.edu    | password | password |

	And the following projects exist:
  	| title   | notes        | owner | is_public |
	| ohsnap! | awesomesauce | 1     | true      |

	Given I am logged in as "alice@cal.edu" with password "password"
	And I am on the project edit page for "ohsnap!"

Scenario: Edit title of project
	When I fill in "project_title" with "arjunisawesome"
	And I press "Save Changes"
	Then I should see "arjunisawesome"
	And I should not see "ohsnap!"

Scenario: Edit description of project
    When I fill in "project_notes" with "snapperclapper"
    And I press "Save Changes"
    Then I should see "snapperclapper"
    And I should not see "awesomesauce"

Scenario: Make project private
	When I uncheck "project_is_public"
	And I press "Save Changes"
	Then I should see "Private"
	And I should not see "Public"

Scenario: Make project public
	When I check "project_is_public"
	And I press "Save Changes"
	Then I should see "Public"
	And I should not see "Private"

Scenario: Only owner can edit
	Given I am logged in as "bob@cal.edu" with password "password"
	And I am on the project edit page for "ohsnap!"
  # Note -- We are currently returning 404's for 401's due to privacy concerns.
	Then I should see "404"
