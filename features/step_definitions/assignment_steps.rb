require 'byebug'

When(/^I click the create assignment button$/) do
  click_button('Add Assignment')
end

When(/^I fill in everything to create a new assignment$/) do
  fill_in 'assignment_title', :with => "test title for assignment"
  fill_in 'assignment_description', :with => "test description for assignment"
  click_button 'save'
end

Then(/^I should see that I created an assignment$/) do
	text = "You have created this assignment"
	if page.respond_to? :should
   	page.should have_content(text)
  else
   	assert page.has_content?(text)
  end
end

Given(/^the following assignments exist:$/) do |table|
  table.hashes.each do |assignment|
    a = Assignment.create(assignment.except(:start_date).except(:due_date))
    a.start_date = eval(assignment[:start_date])
    a.due_date = eval(assignment[:due_date])
    a.save
  end
end

Given(/^I visit the assignment show page for "(.*?)"$/) do |assignment|
  assign = Assignment.find_by_title(assignment)
  visit assignment_show_path assign.id
end

Given(/^I click edit assignment$/) do
  click_button 'Edit Assignment'
end

Then(/^I change title to "(.*?)"$/) do |title|
  fill_in 'assignment_title', :with => title
  click_button 'save'
end

Then(/^I should see that I edited this assignment$/) do
  text = "You have edited this assignment"
	if page.respond_to? :should
   	page.should have_content(text)
  else
   	assert page.has_content?(text)
  end
end

Then(/^I should see all the assignments for "(.*?)"$/) do |course|
	cour = Course.find_by_title(course)
	visit course_show_path cour.id
	cour.assignments.each do |assignment|
	  text = assignment.title
		if page.respond_to? :should
	   	page.should have_content(text)
	  else
	   	assert page.has_content?(text)
	  end
	end
end

Given(/^I click delete assignment$/) do
  click_button 'Delete Assignment'
end

Then(/^I should see that I deleted the assignment$/) do
  text = "Assignment has been deleted"
	if page.respond_to? :should
   	page.should have_content(text)
  else
   	assert page.has_content?(text)
  end
end

When(/^I click on assignment "(.*?)"$/) do |assign|
  a = Assignment.find_by_title(assign)
  click_link("assignment_#{a.id}")
end

Then(/^I should see that I do not have permission to submit an assignment$/) do
  test = "You don't have permission to access this page :("
	if page.respond_to? :should
  	page.should have_content(text)
  else
  	assert page.has_content?(text)
  end
end

Given(/^the following submissions exist:$/) do |table|
	pending # express the regexp above with the code you wish you had
	table.hashes.each do |sub|
	end
end
