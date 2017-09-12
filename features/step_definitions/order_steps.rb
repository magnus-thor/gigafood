Given(/^the following orders exist:$/) do |table|
  table.hashes.each do |order|
    FactoryGirl.create(:order, order)
  end
end

When(/^I press "([^"]*)" for order "([^"]*)"$/) do |link, order_name|
  order = Order.find_by(name: order_name)
  within("#order_#{order.id}") do
    click_link_or_button link
  end
end
