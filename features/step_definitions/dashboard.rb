# Linda: This is where our step definitions live.
# Linda: Let's not try to have low-level step definitions
#        (https://github.com/cucumber/cucumber-rails/issues/174)
# Linda: We can totally do better! 

And /^the following announcements exist:$/ do |announcement_table|
  announcement_table.hashes.each do |announcement|
    Announcement.create(announcement)
  end
end

Then /^(?:|I) can see the dashboard$/ do 
  page.should have_content "Dashboard"
end

Then /^(?:|I) should see the splash page$/ do 
  page.should have_content "Welcome to Snap!"
end

Given /^(?:|I) am on the snap page$/ do
  visit "/snap/"
end