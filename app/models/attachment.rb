class Attachment < ApplicationRecord
  has_attached_file :file
  validates_attachment_presence :file
  validates_attachment_content_type :file,
                                    content_type: ['application/pdf']


  belongs_to :order

end
