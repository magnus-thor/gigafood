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


And(/^"([^"]*)"'s order contains:$/) do |billing_name, table|
  order = Order.find_by(billing_name: billing_name)
  table.hashes.each do |item|
    dish = Dish.find_by(name: item[:dish_name])
    order.add(dish, dish.price, item[:quantity].to_i)
  end
end