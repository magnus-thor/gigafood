class RenameDishToProduct < ActiveRecord::Migration[5.1]
  def change
    rename_table :dishes, :products
  end
end
