And(/^I should see input with id "([^"]*)"$/) do |placeholder|
  expect(page).to have_css("input", id: placeholder)
end