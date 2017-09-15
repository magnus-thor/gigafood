FactoryGirl.define do
  factory :attachment do
    file_type :invoice
    file { File.new("#{Rails.root}/spec/fixtures/blank.pdf") }
    order
  end
end
