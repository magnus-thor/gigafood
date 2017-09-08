ActiveAdmin.register Dish do
  permit_params :name, :description, :price
end
