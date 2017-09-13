class AddColToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery_method, :string
    add_column :orders, :delivery_name, :string
    add_column :orders, :delivery_address, :string
    add_column :orders, :delivery_postal_code, :string
    add_column :orders, :delivery_city, :string
    add_column :orders, :delivery_floor, :string
    add_column :orders, :delivery_door_code, :string
    add_column :orders, :delivery_contact_name, :string
    add_column :orders, :delivery_contact_phone_number, :string
    add_column :orders, :billing_name, :string
    add_column :orders, :billing_company, :string
    add_column :orders, :billing_org_nr, :string
    add_column :orders, :billing_address, :string
    add_column :orders, :billing_postal_code, :string
    add_column :orders, :billing_city, :string
    add_column :orders, :billing_phone, :string
    add_column :orders, :billing_email, :string
  end
end
