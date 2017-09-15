class AddAttributesToAttachment < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :file_type, :string
    add_reference :attachments, :order, foreign_key: true
    add_attachment :attachments, :file
  end
end
