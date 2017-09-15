class OrdersController < ApplicationController
  include ApplicationHelper

  def index
    @order = get_order
  end

  def create
    @order = get_order
    @order.clear

    params[:dishes].each do |dish_key, dish_value|
      dish_id = dish_key[5, dish_key.length].to_i
      dish = Dish.find(dish_id)
      if dish_value.to_i > 0
        if @order.add(dish, dish.price, dish_value.to_i)
          flash[:notice] = "#{dish.name} was successfully added to order!"
        else
          flash[:alert] = 'Item not added, try again!'
        end
      end
    end

    redirect_to orders_path
  end

  def destroy
  end

  def update
    @order = get_order
    @order.update(order_params)
    redirect_to confirm_order_path
  end

  def confirm
    @order = Order.find(params[:id])
    session[:order_id] = nil
  end

  def generate_invoice
    @order = Order.find(params[:id])
    @order.set_payment_due_date
    begin
      PdfGeneratorService.new(@order).generate_invoice
      redirect_back(fallback_location: admin_dashboard_path)
    rescue => e
      flash[:error] = e.message
      redirect_to admin_dashboard_path
    end
  end

  def generate_menu
    @order = Order.find(params[:id])
    begin
      PdfGeneratorService.new(@order).generate_menu
      redirect_back(fallback_location: admin_dashboard_path)
    rescue => e
      flash[:error] = e.message
      redirect_to admin_dashboard_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:delivery_date, :delivery_method, :delivery_name, :delivery_address, :delivery_postal_code, :delivery_city,
                                  :delivery_floor, :delivery_door_code, :delivery_contact_name, :delivery_contact_phone_number, :billing_name,
                                  :billing_company, :billing_org_nr, :billing_address, :billing_postal_code, :billing_city, :billing_phone,
                                  :billing_email, :allergies, :boxes, :status)
  end

end
