# Linda: This is where our step definitions live.
# Linda: Let's not try to have low-level step definitions
#        (https://github.com/cucumber/cucumber-rails/issues/174)
# Linda: We can totally do better! 

Then /^(?:|I) should see "(.*?)"$/ do |input|
	page.should have_content input
end

Then /^(?:|I) should not see "(.*?)"$/ do |input|
	page.should_not have_content input
end

Then /^(?:|I) should see an image$/ do |img|
  # page.should have_xpath("//img") # FIXME: probably broken
  page.should have_css('img', text: 'base64')
end

Then /^(?:|I) should see the link "(.*?)" to "(.*?)"$/ do |link, url|
	page.should have_link(link, :href => url)
end

Then /^(?:|I) should see the submit button "(.*?)"$/ do |input|
  page.should have_selector("input[type=submit][value='#{input}']")
end

Then /^(?:|I) should not see the submit button "(.*?)"$/ do |input|
  page.should_not have_selector("input[type=submit][value='#{input}']")
end

Then /^(?:|I) should see a file input$/ do
  page.should have_selector("input[type=file]")
end

Then /^(?:|I) should not see a file input$/ do
  page.should_not have_selector("input[type=file]")
end

Given /^(?:|I) am logged in as "(.*?)" with password "(.*?)"$/ do |user, password|
  visit login_path
  fill_in "user_email", :with => user
  fill_in "user_password", :with => password
  click_button "Log in"
end

Given /^(?:|I) am on the project details page for "(.*?)"$/ do |page|
  proj = Project.find_by_title page
  visit "/projects/" + proj.id.to_s
end

Given /^(?:|I) am on the project edit page for "(.*?)"$/ do |page|
  proj = Project.find_by_title page
  visit "/projects/" + proj.id.to_s + "/edit"
end

Given /^(?:|I) am on the profile page for "(.*?)"$/ do |username|
  user = User.find_by_username username
  visit "/users/" + user.id.to_s
end

Given /^(?:|I) am on the splash page$/ do
  visit "/"
end

And /^(?:|I) enter in "(.*?)" $/ do |entry|
	flunk "Unimplemented"
end

# check if username/pw is valid, if signup is valid, etc.? 
And /^(?:|my) "(.*?)" (is|are) valid$/ do |field|
	flunk "Unimplemented"
end

#for things like <project's> <attribute> should be 
Then /^(?:|I) should be "(.+)" page$/ do |target|
	flunk "Unimplemented"
end

Given /the following projects exist/ do |project_table|
  project_table.hashes.each do |project|
    Project.create(project)
  end
end

Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create(user)
  end
end

Then /^(?:|I) press "(.*?)" $/ do |button|
  click_button(button)
end

Then(/^I follow "(.*?)"$/) do |link|
  click_link(link)
end

Then(/^I will be on the edit page for "(.*?)"$/) do |target|
  proj = Project.find_by_title target
  page.current_path.should eq "/projects/" + proj.id.to_s + "/edit"
end
