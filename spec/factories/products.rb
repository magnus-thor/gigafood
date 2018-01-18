FactoryGirl.define do
  factory :product do
    name "dish name"
    description "dish features"
    price 1
    category
    of_type 'dish'
    sort_key 1
  end
end
