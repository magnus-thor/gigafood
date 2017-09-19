ActiveAdmin.register OrderItem do
  menu false
  permit_params :owner, :item, :list, :of, :attributes, :on, :model,
  :owner_id, :owner_type, :quantity, :item_id, :item_type, :price_cent,
  :price_currency, :created_at, :updated_at

end
