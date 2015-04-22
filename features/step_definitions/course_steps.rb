# require 'byebug'

Given(/^I visit the new course page$/) do
  visit course_new_path
end

Then(/^I should see that I need to log in$/) do
  text = "Log in"
  if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
end

Given (/^a user is signed up as "(.*?)" with username "(.*?)" and password "(.*?)"$/) do |user, username, password|
  visit signup_path
  fill_in "user_email", :with => user
  fill_in "user_username", :with => username
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  check(tos_agree)
  click_button "Sign up"
end

Given /I enter the course information/ do
	fill_in('course_title', :with => 'Oh SNAP!')
	fill_in('course_description', :with => 'My test snap course')
	fill_in('course_website', :with => 'www.mytestsnapcourse.edu')
	click_button('Create')
	@cour = Course.find_by_title('Oh SNAP!')
end

Then(/^I should see that course creation succeeded$/) do
	text = "You have created this course"
	if page.respond_to? :should
    	page.should have_content(text)
  	else
    	assert page.has_content?(text)
  	end
end

Then /I should see that I cannot create a course/ do
	text = "You don't have permission to access this page :("
	if page.respond_to? :should
    	page.should have_content(text)
  else
    	assert page.has_content?(text)
  end
end

Given /there is a course I did not create/ do
	@cour = Course.create(title: "Not my course", description: "course isn't mine")
	Enrollment.create(user_id: 123456, course_id: @cour.id, role: :teacher)
end

When(/^I go to delete that course$/) do
	visit course_show_path(@cour)
	click_button('Delete')
end

Then /I should see that I cannot delete this course/ do
	text = "You don't have permission to access this page :("
	if page.respond_to? :should
    	page.should have_content(text)
  	else
    	assert page.has_content?(text)
  	end
end

Then(/^I should see that course deletion succeeded$/) do
	text = "Course has been deleted"
	if page.respond_to? :should
    	page.should have_content(text)
  	else
    	assert page.has_content?(text)
  	end
end

Then(/^I should see that I need to log in to delete this course$/) do
  	text = "You don't have permission to access this page :("
	if page.respond_to? :should
    	page.should have_content(text)
  	else
    	assert page.has_content?(text)
  	end
end

Given(/^the following courses exist:$/) do |courseTable|
  courseTable.hashes.each do |course|
    Course.create(course)
  end
end

When(/^I try to visit the edit page for "(.*?)"$/) do |courseTitle|
  @cour = Course.find_by_title(courseTitle)
  visit course_edit_path(@cour)
end

Then(/^I should see that I need to be logged in to edit$/) do
    text = "You don't have permission to access this page :("
	if page.respond_to? :should
    	page.should have_content(text)
  	else
    	assert page.has_content?(text)
  	end
end

Given(/^the following enrollments exist:$/) do |enrollmentTable|
  enrollmentTable.hashes.each do |enrollment|
    Enrollment.create(enrollment)
  end
end

Given(/^user "(.*?)" is enrolled as a teacher in "(.*?)"$/) do |teacheremail, c|
   teacher = User.find_by_email(teacheremail)
   course = Course.find_by_title(c)
   course.addUser(teacher, :teacher)
end

Given(/^user "(.*?)" is enrolled as a student in "(.*?)"$/) do |semail, c|
   student = User.find_by_email(semail)
   course = Course.find_by_title(c)
   course.addUser(student, :student)
end

Then(/^I should see that I do not have permission to edit$/) do
  	test = "You don't have permission to access this page :("
	if page.respond_to? :should
    	page.should have_content(text)
  	else
    	assert page.has_content?(text)
  	end
end

Then(/^I should see "(.*?)" enrolled$/) do |email|
	page.should have_content(email)
end

Then(/^I should not see "(.*?)" enrolled$/) do |email|
	page.should have_no_content(email)
end

When(/^I check drop "(.*?)"$/) do |email|
	field = 'drops_' + email.sub("@", "_")
  	check(field)
end

When(/^I submit the course edit$/) do
  click_button "save"
end

When(/^I try to add "(.*?)"$/) do |email|
  	fill_in 'add_field', :with => email
end

When(/^I try to add "(.*?)" and "(.*?)" at the same time$/) do |user1, user2|
 	fill_in 'adds[1]', :with => user1
 	fill_in 'adds[2]', :with => user2
end

Then(/^I should see "(.*?)" could not be found$/) do |email|
  page.should have_content("Email could not be found: " + email)
end

Then(/^I should not have any email errors$/) do
  page.should have_no_content("Email could not be found: ")
end

When(/^I try to visit the page for "(.*?)"$/) do |course|
  @cour = Course.find_by_title(course)
  visit course_show_path @cour
end

When(/^I go to that course$/) do
  visit course_show_path @cour
end