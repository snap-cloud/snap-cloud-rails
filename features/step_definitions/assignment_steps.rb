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
  visit assignment_show_path assign
end

Given(/^I click edit assignment$/) do
  click_button 'Edit Assignment'
end