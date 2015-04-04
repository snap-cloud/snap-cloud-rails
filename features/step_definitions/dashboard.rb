# Linda: This is where our step definitions live.
# Linda: Let's not try to have low-level step definitions
#        (https://github.com/cucumber/cucumber-rails/issues/174)
# Linda: We can totally do better! 

Given /^the following projects exist$/ do |project_table|
  project_table.hashes.each do |project|
    Project.create(project)
  end
end

And /^the following users exist$/ do |user_table|
  user_table.hashes.each do |user|
    User.create(user)
  end
end

And /^the following announcements exist$/ do |announcement_table|
  announcement_table.hashes.each do |announcement|
    Announcement.create(announcement)
  end
end

