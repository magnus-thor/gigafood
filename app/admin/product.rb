ActiveAdmin.register Product do
  menu priority: 4
  permit_params :name, :description, :price, :min_quantity, :category_id, :sort_key, :of_type

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, input_html: { cols: 5, rows: 5 }
      f.input :price
      f.input :min_quantity
      f.input :category_id, as: :select, collection: Category.all.select { |c| [c.name]}
      f.input :of_type, as: :select, collection: ['dish', 'cutlery']
      f.input :sort_key, input_html: { cols: 1, rows: 1 }
    end
    f.actions
  end
end
