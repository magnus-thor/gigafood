class AddTypeColumnToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :of_type, :string, default: 'dish'
  end
end
