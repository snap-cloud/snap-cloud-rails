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
  text = "You don't have permission to access this page :("
	if page.respond_to? :should
  	page.should have_content(text)
  else
  	assert page.has_content?(text)
  end
end

Given(/^the following submissions exist:$/) do |table|
	table.hashes.each do |sub|
		Submission.create(sub)
	end
end

When(/^I select "(.*?)" to submit$/) do |proj|
	proj = Project.find_by_title(proj)
  select proj.id, :from => "submission[project_id]"
  click_button 'Submit'
end

Then(/^I should see that my submission was successful$/) do
  test = "Yay, your project was submitted!"
	if page.respond_to? :should
  	page.should have_content(text)
  else
  	assert page.has_content?(text)
  end
end

When(/^I should see all of the submissions "(.*?)"$/) do |assign|
  assignment = Assignment.find_by_title(assign)
  assignment.submissions.each do |sub|
	  text = sub.project.title
		if page.respond_to? :should
	   	page.should have_content(text)
	  else
	   	assert page.has_content?(text)
	  end
	end
end

Then(/^I should not be able to submit a project to it$/) do
  text = "Submission for this assignment has been closed."
	if page.respond_to? :should
  	page.should have_content(text)
  else
  	assert page.has_content?(text)
  end
end

Given(/^user "(.*?)" with password "(.*?)" submits "(.*?)" "(.*?)" "(.*?)" to "(.*?)"$/) do |user, password, proj1, proj2, proj3, assign|
  if page.body.include? "Logout"
    visit logout_path
  end
  visit login_path
  fill_in "user_login", :with => user
  fill_in "user_password", :with => password
  click_button "Log in"
  assignment = Assignment.find_by_title(assign)
  visit assignment_show_path assignment.id
  proj1 = Project.find_by_title(proj1)
  select proj1.id, :from => "submission[project_id]"
  click_button 'Submit'
  proj2 = Project.find_by_title(proj2)
  select proj2.id, :from => "submission[project_id]"
  click_button 'Submit'
  proj3 = Project.find_by_title(proj3)
  select proj3.id, :from => "submission[project_id]"
  click_button 'Submit'

end
