def path_to(page_name)
  case page_name
  when 'the dashboard'
    admin_root_path
  when 'the landing page'
    root_path
  when 'order page'
    order_path
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

Then(/^"([^"]*)" should receive an email$/) do |address|
  #mailbox_for(address).size.should == n.to_i
  expect(mailbox_for(address).size).to eq 1
end

Then /^"([^"]*)" should see "(.*)" in the subject$/ do |address, text|
  open_email(address)
  expect(current_email.subject).to match Regexp.new(text)
end

Then /^"([^"]*)" should see "(.*)" in the email$/ do |address, text|
  open_email(address)
  expect(current_email.body).to match Regexp.new(text)
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

Then(/^I select "([^"]*)" from "([^"]*)"$/) do |arg1, arg2|
  select "Starter", :from => "dish_category_id"
end
