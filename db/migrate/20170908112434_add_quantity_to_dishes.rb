class AddQuantityToDishes < ActiveRecord::Migration[5.1]
  def change
    add_column :dishes, :min_quantity, :integer, default: 10
  end
end
