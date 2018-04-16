ActiveAdmin.register Order do
  menu priority: 6
  permit_params :email, :delivery_date, :delivery_method, :delivery_name, :delivery_address, :delivery_postal_code, :delivery_city,
                :delivery_floor, :delivery_door_code, :delivery_contact_name, :delivery_contact_phone_number, :billing_name,
                :billing_company, :billing_org_nr, :billing_address, :billing_postal_code, :billing_city, :billing_phone,
                :billing_email, :allergies, :boxes, :status, :shopping_cart_items, :order_item, :due_date

  controller do
    def update
      @order = Order.find(params[:id])
      if params[:dishes]
        params[:dishes].each do |dish_id, dish_value|
          dish = Product.find(dish_id)
          if dish_value.to_i > 0
            @order.add(dish, dish.price, dish_value.to_i)
          end
        end
      end
      @order.save
      redirect_to admin_order_path(resource), notice: "Order was successfully updated"
    end
  end

  scope 'All', :all
  scope 'Approved / Submitted', :non_pending
  scope 'Pending', :pending

  action_item :confirm_order, only: :show, if: proc {resource.status != 'canceled' and resource.status != 'approved'} do
    link_to 'Confirm Order', confirm_admin_order_path(resource), method: :put
  end

  action_item :cancel_order, only: :show, if: proc {resource.status != 'canceled' and resource.status != 'approved'} do
    link_to 'Cancel Order', cancel_admin_order_path(resource), method: :put
  end

  action_item :generate_invoice, only: :show, if: proc {!resource.has_invoice? and resource.status == 'approved'} do
    link_to 'Generate Invoice', generate_invoice_order_path, method: :put
  end

  action_item :generate_menu, only: :show, if: proc {!resource.has_menu? and resource.status == 'approved'} do
    link_to 'Generate Menu', generate_menu_order_path, method: :put
  end

  action_item :view_invoice, only: :show, if: proc {resource.has_invoice?} do
    link_to 'View Invoice', resource.attachments.where(file_type: 'invoice').first.file.url, target: '_blank', rel: 'nofollow', style: 'background-color: green !Important;'
  end

  action_item :view_menu, only: :show, if: proc {resource.has_menu?} do
    link_to 'View Menu', resource.attachments.where(file_type: 'menu').first.file.url, target: '_blank', rel: 'nofollow', style: 'background-color: green !Important;'
  end

  action_item :view_menu, only: :edit do
    link_to 'Add Products', admin_add_products_path(id: resource.id)
  end

  member_action :confirm, method: :put do
    @order = Order.find(params[:id])
    @order.status = 'approved'
    @order.save
    ConfirmationMailer.confirmation_email(@order).deliver_now
    ConfirmationMailer.move_by_bike_email('boka@movebybike.se', @order).deliver_now
    redirect_to resource_path, notice: 'Confirmed!'
  end

  member_action :cancel, method: :put do
    @order = Order.find(params[:id])
    @order.status = 'canceled'
    @order.save
    ConfirmationMailer.cancelation_email(@order).deliver_now
    redirect_to resource_path, notice: 'Canceled!'
  end

  index do
    selectable_column
    column :id do |order|
      link_to 'Order: ' + order.id.to_s, admin_order_path(order)
    end
    column :delivery_date
    column :delivery_method
    column :billing_name
    column :allergies
    column :boxes
    actions
  end

  filter :status, as: :select, collection: -> {['submitted', 'approved', 'pending']}
  filter :delivery_date
  filter :delivery_method, as: :select, collection: -> {['pick up', 'delivery']}

  show do
    h3 'Order Items'
    table_for order.shopping_cart_items do
      column :item
      column :price
      column :quantity
      column :delete do |order_item|
        link_to 'Delete', admin_order_item_path(order_item), method: :delete, id: "delete_#{order_item.id}"
      end

      column :show do |order_item|
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

  form do |f|
    f.inputs do
      f.input :delivery_date
      f.input :allergies
      f.input :boxes
      f.input :status, as: :select, collection: ['submitted', 'approved', 'pending']
      f.input :email
      f.input :delivery_method
      f.input :delivery_name
      f.input :delivery_address
      f.input :delivery_postal_code
      f.input :delivery_city
      f.input :delivery_door_code
      f.input :delivery_contact_name
      f.input :delivery_contact_phone_number
      f.input :billing_name
      f.input :billing_company
      f.input :billing_org_nr
      f.input :billing_address
      f.input :billing_postal_code
      f.input :billing_city
      f.input :billing_phone
      f.input :billing_email
      f.input :due_date
    end
    f.actions
  end
end
