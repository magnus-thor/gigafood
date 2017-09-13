FactoryGirl.define do
  factory :order do
    allergies 'peanuts'
    delivery_method 'pick up'
    delivery_name 'Big corp'
    delivery_address 'Street 42'
    delivery_postal_code '123 45'
    delivery_city 'Town'
    delivery_floor '3'
    delivery_door_code '1234'
    delivery_contact_name 'John Doe'
    delivery_contact_phone_number '555 123 45 66'
    billing_name 'Big corp 111'
    billing_company 'Big corp 222'
    billing_org_nr '19900101-1234'
    billing_address 'Street 42'
    billing_postal_code '123 45'
    billing_city 'Town'
    billing_phone '555 123 45 66'
    billing_email 'invoce@bigcorp.com'
  end
end
