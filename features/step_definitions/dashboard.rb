# Linda: This is where our step definitions live.
# Linda: Let's not try to have low-level step definitions
#        (https://github.com/cucumber/cucumber-rails/issues/174)
# Linda: We can totally do better! 

And /^the following announcements exist:$/ do |announcement_table|
  announcement_table.hashes.each do |announcement|
    Announcement.create(announcement)
  end
end

Given /^(?:|I) am not logged in$/ do |user|
  #nothing needs to be done.. 
end

And /^(?:|I) visit the home page$/ do |page_to_visit|
  visit home_path 
end

Then /^(?:|I) should see the splash page$/ do |page|
  page.should have_content 'Welcome to Snap!'
end 

Then /^(?:|I) should see the dashboard page$/ do |page|
  page.should have_content 'Dashboard'
end 

And /^(?:|I) should see a news feed with my "(.*?)"$/ do |announcements| 
end

And /^(?:|I) should see a projects listing with my "(.*?)"$/ do |projects|
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

Then /^(?:|I) will be on the profile page for "(.*?)"$/ do |target|
  usr = User.find_by_username target
  page.current_path.should eq "/users/" + usr.id.to_s
end

Then /^(?:|I) should be logged out$/ do |target|
  page.current_path.should eq "/"
  page.should have_content 'Sign In'
end
