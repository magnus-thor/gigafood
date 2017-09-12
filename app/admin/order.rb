ActiveAdmin.register Order do

  permit_params :name, :description, :price, :delivery_date, :address, :phone, :allergies, :boxes


  action_item :confirm_order, only: :show do
    link_to 'Confirm Order', confirm_admin_order_path(resource), method: :put
  end

  action_item :cancel_order, only: :show do
    link_to 'Cancel Order', cancel_admin_order_path(resource), method: :put
  end

  member_action :confirm, method: :put do
    @order = Order.find(params[:id])
    @order.status = 'approved'
    @order.save
    ConfirmationMailer.confirmation_email(@order).deliver
    redirect_to resource_path, notice: "Confirmed!"
  end

  member_action :cancel, method: :put do
    @order = Order.find(params[:id])
    @order.status = 'canceled'
    @order.save
    ConfirmationMailer.cancelation_email(@order).deliver
    redirect_to resource_path, notice: "Canceled!"
  end
end
