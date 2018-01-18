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
    dish = Product.find_by(name: item[:dish_name])
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


And(/^the order should have delivery method set to "([^"]*)"$/) do |delivery_method|
  @order = @order || Order.last
  @order.reload
  expect(@order.delivery_method).to eq delivery_method
end

Then(/^the tax for the order should be "([^"]*)"$/) do |tax|
  @order = @order || Order.last
  @order.reload
  expect(@order.taxes).to eq Money.new(tax.to_f * 100)
end

Given(/^"([^"]*)"'s order contains no items$/) do |billing_name|
  @order = Order.find_by(billing_name: billing_name)
  @order.clear if @order.shopping_cart_items
end

Then(/^I select "([^"]*)" and fill in quantity with "([^"]*)"$/) do |option, quantity|
  fill_in "#{option}_quantity", with: quantity
end

And(/^I fill in all relevant fields and submit the order$/) do
  steps %q{
      And I fill in Delivery Date with "2017-11-10 12:00"
      And I fill in "Delivery Name" with "Hungry corp Inc"
      And I fill in "Delivery Address" with "Street 42"
      And I fill in "Delivery_Postal_Code" with "123 45"
      And I fill in "Delivery City" with "Town"
      And I fill in "Delivery Floor" with "3"
      And I fill in "Delivery Door Code" with "1111"
      And I fill in "Delivery Contact Name" with "John Doe"
      And I fill in "Delivery Contact Phone" with "555 123 45 67"
      And I fill in "Billing Name" with "John Doe"
      And I fill in "Billing Company" with "Hungry corp Inc"
      And I fill in "Billing Organisation Number" with "19210713-1444"
      And I fill in "Billing Address" with "Street 42"
      And I fill in "Billing_Postal_Code" with "123 45"
      And I fill in "Billing City" with "Town"
      And I fill in "Billing Contact Phone" with "555 123 55 11"
      And I fill in "Billing email" with "invoice@hungrycorp.com"
      And I click on "Submit Order"

  }
end

And(/^I fill in "([^"]*)" with "([^"]*)" to buy 10 dishes$/) do |dish_name, value|
  dish_id = Product.find_by(name: dish_name).id
  fill_in("dish_#{dish_id}", with: value)
end
