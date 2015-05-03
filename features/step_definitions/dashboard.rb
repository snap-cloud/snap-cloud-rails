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
  page.should have_content "Welcome to snap"
end

Then /^(?:|I) am on the snap page$/ do
  visit "/snap/"
end

Then /^(?:|I) should see my announcements$/ do 
  #check that assignments are populated.
  announcements = Announcement.all
  expect(announcements.length).to eq(2)
  announcements.each do |announcement| 
    #see if the announcements are what is generated
    ['cs169','snap!'].include? announcement.source
    ['foo','bar'].include? announcement.text
  end 
end

Then /^(?:|I) should see my assignments$/ do 
  #check for my assignmetns, and that assignments are for a class I am in.
  user = User.find_by_username('linda')
  assignment =  user.assignments.first
  expect(assignment.title).to eq('assign1')
  expect(assignment.course_id).to eq(user.courses.first.id)
end

Then /^(?:|I) should see my courses$/ do 
  #check that I'm in the right course. 
  user = User.find_by_username('linda')
  cs169 = user.courses.first
  expect(cs169.title).to eq('cs169')
end

Then /^(?:|I) should see my projects$/ do 
  #check that I have all my projects, and all projects are owned by me.
  user = User.find_by_username('linda')
  projects = Project.where(:owner => user.id).all
  expect(projects.length).to eq(2)
  projects.each do |project| 
    expect(project.owner).to eq(user.id)
  end 
end

Then /^(?:|I) should see navigation links$/ do 
  page.should have_content "Home"
  page.should have_content "Profile"
  page.should have_content "Projects"
  page.should have_content "Courses"
end