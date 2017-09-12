Given(/^the following categories exist:$/) do |table|
  table.hashes.each do | category |
    Category.create(category)
  end
end

When(/^I press "([^"]*)" for "([^"]*)"$/) do |link, category|
  cat = Category.find_by(name: category)
  within("#category_#{cat.id}") do
    click_link_or_button link
  end
end
