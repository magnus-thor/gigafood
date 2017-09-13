class Attachment < ApplicationRecord
  has_attached_file :file,
                    storage: :s3,
                    s3_credentials: {
                        bucket: ENV['AWS_BUCKET'],
                        access_key_id: ENV['AWS_ACCESS_KEY'],
                        secret_access_key: ENV['AWS_SECRET_KEY'],
                        s3_region: ENV['AWS_REGION'],
                        url: :s3_domain_url,
                        s3_host_name: "s3-#{ENV['AWS_REGION']}.amazonaws.com"
                    },
  validates_attachment_presence :file
  validates_attachment_content_type :file,
                                    content_type: ['application/pdf']


  belongs_to :order

end
