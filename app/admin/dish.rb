ActiveAdmin.register Dish do
  permit_params :name, :description, :price, :min_quantity, :category_id
end
