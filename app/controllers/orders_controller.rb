class OrdersController < ApplicationController
  include ApplicationHelper

  before_action :setup_variables, only: [:index, :create, :update]

  def index
  end

  def create
    @order.clear

    params[:dishes].each do |dish_key, dish_value|
      dish_id = dish_key[5, dish_key.length].to_i
      dish = Product.find(dish_id)
      if dish_value.to_i > 0
        @order.add(dish, dish.price, dish_value.to_i)
      end
    end

    redirect_to orders_path
  end

  def destroy
  end

  def update
    if params[:commit] == 'Add'
      quantity = params[:cutlery_quantity].to_i
      @order.add(@cutlery, 2, quantity)
      flash[:success] = 'Cutlery Added'
      redirect_to orders_path
    elsif params[:commit] == 'Remove'
      @order.remove(@cutlery, @order.shopping_cart_items.last.quantity) # TODO refactor
      flash[:success] = 'Cutlery Removed'
      redirect_to orders_path
    else
      if @order.update(order_params)
        redirect_to confirm_order_path
      else
        flash[:alert] = 'Error when saving order!'
        redirect_to orders_path
      end
    end
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

  def setup_variables
    @order = get_order
    @cutlery = Product.cutlery.first
  end

  def order_params
    params.require(:order).permit(:delivery_date, :delivery_method, :delivery_name, :delivery_address, :delivery_postal_code, :delivery_city,
                                  :delivery_floor, :delivery_door_code, :delivery_contact_name, :delivery_contact_phone_number, :billing_name,
                                  :billing_company, :billing_org_nr, :billing_address, :billing_postal_code, :billing_city, :billing_phone,
                                  :billing_email, :allergies, :boxes, :status)
  end
end
