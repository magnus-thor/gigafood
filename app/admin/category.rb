ActiveAdmin.register Category do
 menu priority: 3

 permit_params :name, :description, :sort_key
end
