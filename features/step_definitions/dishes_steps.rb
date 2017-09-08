Given(/^the following dishes exist:$/) do |table|
  table.hashes.each do |dish|
    FactoryGirl.create(:dish, dish)
  end
end

When(/^I press "([^"]*)" for dish "([^"]*)"$/) do |link, dish_name|
  #pending # Write code here that turns the phrase above into concrete actions
  dish = Dish.find_by(name: dish_name)
  within("#dish_#{dish.id}") do
    click_link_or_button link
  end
end
