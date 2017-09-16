class AddSortKeyToDish < ActiveRecord::Migration[5.1]
  def change
    add_column :dishes, :sort_key, :integer
  end
end
