FactoryGirl.define do
  factory :attachment do
    type :invoice
    attachment { File.new("#{Rails.root}/spec/fixtures/blank.pdf") }
  end
end
