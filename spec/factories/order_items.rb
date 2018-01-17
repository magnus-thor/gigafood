FactoryGirl.define do
  factory :order_item do
    association :owner, factory: :order
    association :item, factory: :product
  end
end
