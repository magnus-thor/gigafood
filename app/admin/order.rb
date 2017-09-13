ActiveAdmin.register Order do

  permit_params :delivery_date, :delivery_method, :delivery_name, :delivery_address, :delivery_postal_code, :delivery_city,
                :delivery_floor, :delivery_door_code, :delivery_contact_name, :delivery_contact_phone_number, :billing_name,
                :billing_company, :billing_org_nr, :billing_address, :billing_postal_code, :billing_city, :billing_phone,
                :billing_email, :allergies, :boxes, :status

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
