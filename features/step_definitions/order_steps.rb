Given(/^the following orders exist:$/) do |table|
  table.hashes.each do |order|
    FactoryGirl.create(:order, order)
  end
end

When(/^I press "([^"]*)" for order "([^"]*)"$/) do |link, order_name|
  order = Order.find_by billing_name: order_name
  within("#order_#{order.id}") do
    click_link_or_button link
  end
end

And(/^I fill in Delivery Date with "([^"]*)"$/) do |date|
  fill_in('order_delivery_date', with: date)
end


Given(/^"([^"]*)"'s order contains:$/) do |billing_name, table|
  @order = Order.find_by(billing_name: billing_name)
  table.hashes.each do |item|
    dish = Dish.find_by(name: item[:dish_name])
    @order.add(dish, dish.price, item[:quantity].to_i)
  end
end


Then(/^the total for the order should be "([^"]*)"$/) do |total|
  @order.reload
  expect(@order.total).to eq Money.new(total.to_f * 100)
end

Then /^the subtotal for the cart should be "([^"]*)"$/ do |subtotal|
  @order = @order || Order.last
  @order.reload
  expect(@order.subtotal).to eq Money.new(subtotal.to_f * 100)
end

Then(/^the tax for the order should be "([^"]*)"$/) do |tax|
  @order = @order || Order.last
  @order.reload
  expect(@order.taxes).to eq Money.new(tax.to_f * 100)
end