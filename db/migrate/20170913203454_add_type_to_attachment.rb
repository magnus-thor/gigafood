class AddTypeToAttachment < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :type, :string
    add_reference :attachments, :order, foreign_key: true
  end
end
