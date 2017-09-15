class AddDueDateToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :due_date, :datetime
  end
end
