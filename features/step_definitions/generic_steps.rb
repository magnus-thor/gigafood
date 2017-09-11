def path_to(page_name)
  case page_name
  when 'the dashboard'
    admin_root_path
  when 'the landing page'
    root_path
  when 'order page'
    orders_path
  else
    error
  end
end

Then(/^show me the page$/) do
  save_and_open_page
end

When(/^I confirm popup$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^I click on "([^"]*)"$/) do |link_or_button|
  click_link_or_button link_or_button
end

When /^(?:I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  expect(URI.parse(current_url).path).to eq path_to page_name
end
