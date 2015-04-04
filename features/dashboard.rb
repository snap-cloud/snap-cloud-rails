# Linda: This is where our step definitions live.
# Linda: Let's not try to have low-level step definitions
#        (https://github.com/cucumber/cucumber-rails/issues/174)
# Linda: We can totally do better! 

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

Given /the following announcements exist/ do |announcement_table|
  announcement_table.hashes.each do |announcement|
    Announcement.create(announcement)
  end
end

Given /^(?:|I) am not logged in$/ do |user|
  #nothing needs to be done.. 
  end

Given /^(?:|I) am logged in as "(.*?)" $/ do |user|
  password = user.password
	visit login_path
  fill_in "user_email", :with => user
  fill_in "user_password", :with => password
  click_button "Log in"
end

And /^(?:|I) visit the home page$/ do |page_to_visit|
  visit home_path 
end

Then /^(?:|I) should see the splash page$/ do |page|
  page.should have_content 'WELCOME TO SNAP!'
end 

Then /^(?:|I) should see the dashboard page$/ do |page|
  page.should have_content 'Dashboard'
end 

And /^(?:|I) should see a news feed with my "(.*?)"$/ do |announcements| 
end

And /^(?:|I) should see a projects listing with my "(.*?)"$/ do |projects|
end

Then /^(?:|I) press "(.*?)" $/ do |button|
  click_button(button)
end

Then(/^I follow "(.*?)"$/) do |link|
  click_link(link)
end

Then /^(?:|I) will be on the snap page$/ do |target|
  page.current_path.should eq "/snap/"
end

Then /^(?:|I) will be on the help page$/ do |target|
  page.current_path.should eq "/help"
end

Then /^(?:|I) will be on the about snap page$/ do |target|
  page.current_path.should eq "/about"
end

Then /^(?:|I) will be on my profile page$/ do |target|
  proj = Project.find_by_title target
  page.current_path.should eq "/users/" + proj.id.to_s + "/edit"
end

Then /^(?:|I) should be logged out$/ do |target|
  proj = Project.find_by_title target
  page.current_path.should eq "/projects/" + proj.id.to_s + "/edit"
end



