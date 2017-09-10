Given(/^the following dishes exist:$/) do |table|
  table.hashes.each do |dish|
    FactoryGirl.create(:dish, dish)
  end
end

When(/^I press "([^"]*)" for dish "([^"]*)"$/) do |link, dish_name|
  dish = Dish.find_by(name: dish_name)
  within("#dish_#{dish.id}") do
    click_link_or_button link
  end
end

When(/^I click on \+ for "([^"]*)"$/) do |dish_name|
  dish_id = Dish.find_by(name: dish_name).id

  within "#dish_item_#{dish_id}" do
    click_link_or_button '+'
  end
end

Then(/^"([^"]*)" quantity should be "([^"]*)"$/) do |dish_name, dish_quantity|
  dish_id = Dish.find_by(name: dish_name).id
  expect(page).to have_field("dish_#{dish_id}", with: dish_quantity)
end


Then(/^I should see the button "([^"]*)"$/) do |button_name|
  expect(page).to have_button(button_name)
end
