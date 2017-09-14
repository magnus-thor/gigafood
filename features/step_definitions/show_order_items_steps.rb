Given(/^the following orders items exist in the order:$/) do |table|
  order = Order.find_by(billing_name: 'Bob Schmob')
  table.hashes.each do | dish_params |
    dish = Dish.find_by(name: dish_params['dish'])
    order.add(dish, dish.price, dish_params['quantity'])
  end
end
