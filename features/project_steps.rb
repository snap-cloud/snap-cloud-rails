# Linda: This is where our step definitions live.
# Linda: Let's not try to have low-level step definitions
#        (https://github.com/cucumber/cucumber-rails/issues/174)
# Linda: We can totally do better! 

Then /^(?:|I) should see "(.+)"$/ do |input|
	assert page.body.include? input
end

Then /^(?:|I) should not see "(.+)"$/ do |input|
	assert !page.body.include? input
end

Given /^(?:|I) am logged in as "(.+)"$/ do |user|
	flunk "Unimplemented"
end

Given /^(?:|I) am on the project details page for "(.+)"$/ do |page|
	proj = Project.find_by_title page
  visit "/project/" + proj.id
end

And /^(?:|I) enter in "(.+)" $/ do |entry|
	flunk "Unimplemented"
end

# check if username/pw is valid, if signup is valid, etc.? 
And /^(?:|my) "(.+)" (is|are) valid$/ do |field|
	flunk "Unimplemented"
end

#for things like <project's> <attribute> should be 
Then /^(?:|I) should be "(.+)" page$/ do |page|
	flunk "Unimplemented"
end

Given /the following projects exist/ do |project_table|
  project_table.hashes.each do |project|
    Project.create(project)
  end
end

Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create(project)
  end
end
