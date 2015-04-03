Given /I enter the course information/ do
	fill_in('course[title]', :with => 'Oh SNAP!')
	fill_in('course[description]', :with => 'My test snap course')
	fill_in('course[website]', :with => 'www.mytestsnapcourse.edu')
	click_button('Create')
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
	visit(course_delete_path(@cour.id))
end

Then /I should see that I cannot delete this course/ do
	text = "You do not have permission to delete this course"
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