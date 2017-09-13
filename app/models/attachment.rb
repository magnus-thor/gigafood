class Attachment < ApplicationRecord
  has_attached_file :file
  validates_attachment_presence :file

  belongs_to :order

end
