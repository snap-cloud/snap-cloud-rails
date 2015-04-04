Given(/^I visit the new course page$/) do
  visit course_new_path
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
	text = "Log in to create a course"
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
	text = "You do not have permission to edit or delete this course"
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
  	text = "You must log in to edit or delete courses"
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
    text = "You must log in to edit or delete courses"
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

Given(/^user "(.*?)" is enrolled as a student in "(.*?)"$/) do |studentUsername, c|
   student = User.find_by_username(studentUsername)
   course = Course.find_by_title(c)
   course.addUser(student, :student)
end

Then(/^I should see that I do not have permission to edit$/) do
  	test = "You do not have permission to edit or delete this course"
	if page.respond_to? :should
    	page.should have_content(text)
  	else
    	assert page.has_content?(text)
  	end
end

Then(/^I should see "(.*?)" enrolled$/) do |username|
	student = User.find_by_username(username)
	page.should have_content(student.email)
end

Then(/^I should not see "(.*?)" enrolled$/) do |username|
	student = User.find_by_username(username)
	page.should have_no_content(student.email)
end

When(/^I check drop "(.*?)"$/) do |username|
  	student = User.find_by_username(username)
	field = 'drops_' + student.email.sub("@", "_")
  	check(field)
end

When(/^I submit the course edit$/) do
  click_button "save"
end

When(/^I try to add "(.*?)"$/) do |username|
	student = User.find_by_username(username)
  	fill_in 'add_field', :with => student.email
end

When(/^I try to add "(.*?)" and "(.*?)" at the same time$/) do |user1, user2|
  	student1 = User.find_by_username(user1)
 	student2 = User.find_by_username(user2)
 	fill_in 'adds[1]', :with => student1.email
 	fill_in 'adds[2]', :with =>student2.email 
end