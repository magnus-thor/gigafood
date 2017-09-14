ActiveAdmin.register Order do

  permit_params :delivery_date, :delivery_method, :delivery_name, :delivery_address, :delivery_postal_code, :delivery_city,
                :delivery_floor, :delivery_door_code, :delivery_contact_name, :delivery_contact_phone_number, :billing_name,
                :billing_company, :billing_org_nr, :billing_address, :billing_postal_code, :billing_city, :billing_phone,
                :billing_email, :allergies, :boxes, :status, :shopping_cart_items, :order_item

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

  show do

    h3 'Order Items'
    table_for order.shopping_cart_items do
      column :item
      column :price
      column :quantity
      column :Delete do |order_item|
        link_to 'Delete', admin_order_item_path(order_item), method: :delete, id: "delete_#{order_item.id}"
      end
      column :Show do  |order_item|
        link_to 'Show', admin_order_item_path(order_item)
      end
    end

    attributes_table do
      row :delivery_date
      row :delivery_method
      row :delivery_name
      row :delivery_address
      row :delivery_postal_code
      row :delivery_city
      row :delivery_floor
      row :delivery_door_code
      row :delivery_contact_name
      row :delivery_contact_phone_number
      row :billing_name
      row :billing_company
      row :billing_org_nr
      row :billing_address
      row :billing_postal_code
      row :billing_city
      row :billing_phone
      row :billing_email
      row :allergies
      row :boxes
      row :status
    end
  end

end
