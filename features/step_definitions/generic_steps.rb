Then(/^show me the page$/) do
  save_and_open_page
end

When(/^I press "([^"]*)" on "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I confirm popup$/) do
  page.driver.browser.switch_to.alert.accept
end
