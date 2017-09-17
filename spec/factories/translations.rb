FactoryGirl.define do
  factory :translation do
    locale :en
    key 'my_key'
    value 'My Vamue'
    interpolations ['']
    is_proc false
  end
end
