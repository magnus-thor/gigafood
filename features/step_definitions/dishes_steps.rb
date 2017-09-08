Given(/^the following dishes exist:$/) do |table|
  table.hashes do |dish|
    FactoryGirl.create(:dish, dish)
  end
end
