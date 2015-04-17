When(/^I click the create assignment button$/) do
  click_button('Add Assignment')
end

When(/^I fill in everything to create a new assignment$/) do
  pending # express the regexp above with the code you wish you had
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
    Assignment.create(assignment)
  end
end