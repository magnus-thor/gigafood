And(/^I should see input with id "([^"]*)"$/) do |placeholder|
  expect(page).to have_css("input", id: placeholder)
end

And(/^I select delivery$/) do
  choose("delivery")
end