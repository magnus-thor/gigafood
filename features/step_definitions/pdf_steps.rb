Then(/^an invoice for the order should be created$/) do
  expect(@order.attachments.first.file_type).to eq 'invoice'
end

Then(/^a menu for the order should be created$/) do
  expect(@order.attachments.first.file_type).to eq 'menu'
end

And(/^the pdf should contain "([^"]*)"$/) do |content|

  remote_pdf = open(Rails.root.join('spec', 'fixtures', 'tmp', 'tmp.pdf'), 'wb') do |file|
    file << open(@order.attachments.first.file.url).read
  end
  pdf = PDF::Inspector::Text.analyze_file(remote_pdf)
  expect(pdf.strings).to include content
end

Given(/^an Invoice has been generated for "([^"]*)"'s order$/) do |billing_email|
  steps %Q{
      Given "#{billing_email}"'s order contains:
        | dish_name | quantity |
        | Dish 1    | 10       |
        | Dish 2    | 20       |
      And I click on "Orders"
      And I press "View" for order "Bob Schmob"
      And I press "Generate Invoice"
      }
end

Given(/^an Menu has been generated for "([^"]*)"'s order$/) do |billing_email|
  steps %q{
      And I press "Generate Menu"
      }
end

Then(/^I should see a pdf in a new window$/) do
  switch_to_window windows.last
  expect(page.response_headers['Content-Type']).to eq 'application/pdf'
end