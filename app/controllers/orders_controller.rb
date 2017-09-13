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
  end

  def generate_invoice
    @order = Order.find(params[:id])
    # Render PDF file
    # TODO: This is WIP. Needs to be extracted to a module
    pdf_opts = {
        page_size: 'A4',
        page_layout: :portrait, left_margin: 20, right_margin: 20,
        top_margin: 20, bottom_margin: 20, skip_encoding: true
    }
    helpers = ActionController::Base.helpers
    filename = [t('invoice.header'), @order.id, @order.billing_name].join('-') + '.pdf'
    Prawn::Document.generate(filename, pdf_opts) do |pdf|
      pdf.move_down 50
      pdf.font Rails.root.join('app', 'assets', 'fonts', 'futura.ttf')
      pdf.text t('invoice.header'), size: 40
      pdf.move_down 30
      pdf.font Rails.root.join('app', 'assets', 'fonts', 'futura.ttf')
      pdf.text @order.billing_name, size: 14
      pdf.move_down 16
      pdf.text "Tax (VAT): #{helpers.humanized_money_with_symbol @order.taxes}", size: 14
      pdf.move_down 16
      pdf.text "Total: #{helpers.humanized_money_with_symbol @order.total}", size: 14
    end

    # Attach file to @order with file_type :invoice
    # TODO: This is WIP. Needs to be extracted to a module
    generated_file = File.open(Rails.root.join(filename))
    if @order.attachments.create(file: generated_file, file_type: :invoice)
      if File.exist?(generated_file)
        File.delete(generated_file)
      end
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
