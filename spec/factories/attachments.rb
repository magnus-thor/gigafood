FactoryGirl.define do
  factory :attachment do
    type :invoice
    file { File.new("#{Rails.root}/spec/fixtures/blank.pdf") }
    order
  end
end
