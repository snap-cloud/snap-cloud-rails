ture: Editing a Project
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

	And I am on the project edit page for "ohsnap!"

Scenario: Edit title of project
	Given I am logged in as "alice@cal.edu" with password "password"
	When I enter "arjunisawesome" as the "project_name"
	And I press "Submit"
	Then I should see "arjunisawesome"
	And I should not see "ohsnap!"

Scenario: Edit description of project
	Given I am logged in as "alice@cal.edu" with password "password"
        When I enter "snapperclapper" as the "project_description"
        And I press "Submit"
        Then I should see "snapperclapper"
        And I should not see "awesomesauce"
