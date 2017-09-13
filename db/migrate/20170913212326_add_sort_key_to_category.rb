class AddSortKeyToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :sort_key, :integer
  end
end
