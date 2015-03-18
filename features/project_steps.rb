# Linda: This is where our step definitions live.
# Linda: Let's not try to have low-level step definitions
#        (https://github.com/cucumber/cucumber-rails/issues/174)
# Linda: We can totally do better! 

Then /^(?:|I) should see (.+)$/ do
	flunk "Unimplemented"
end

Then /^(?:|I) should not see (.+)$/ do
	flunk "Unimplemented"
end

Given /^(?:|I) am logged in$/ do
	flunk "Unimplemented"
end

Then /^(?:|I) will be logged in$/ do
	flunk "Unimplemented"
end

Given /^(?:|I) am on the (.+) page$/ do
	flunk "Unimplemented"
end

And /^(?:|I) enter in (.+) $/ do
	flunk "Unimplemented"
end

# check if username/pw is valid, if signup is valid, etc.? 
And /^(?:|my) (.+) (is|are) valid$/ do
	flunk "Unimplemented"
end

#for things like <project's> <attribute> should be 
Then /^(.+) should be (.+) page$/ do
	flunk "Unimplemented"
end

Given /the following projects exist/ do |project_table|
  project_table.hashes.each do |project|
  Project.create(project)
  end
end  