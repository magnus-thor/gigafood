class OrdersController < ApplicationController
  include ApplicationHelper

  def index
    @order = get_order
  end

  def create
    get_order.clear

    params["dishes"].each do |dish_key, dish_value|
      dish_id = dish_key[5,dish_key.length].to_i
      dish = Dish.find(dish_id)
      if dish_value.to_i > 0
        if get_order.add(dish, dish.price, dish_value.to_i)
          flash[:notice] = dish.name + " was successfully added to order!"
        else
          flash[:alert] = "Item not added, try again!"
        end
      end
    end

    redirect_to orders_path
  end

  def destroy
  end
end
