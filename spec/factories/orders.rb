FactoryGirl.define do
  factory :order do
    name "Bob Schmob"
    description "Bobs Burgers"
    price 1
    order_date "2017-09-09 10:15:58"
    delivery_date "2017-09-09 10:15:58"
    address "Bobs address"
    phone "070444444"
    allergies "peanuts"
  end
end
