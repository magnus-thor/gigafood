ActiveAdmin.register Product do
  menu priority: 4
  permit_params :name, :description, :price, :min_quantity, :category_id, :sort_key
end
