def ensure_user_created(email)
  user = AdminUser.where(email: email).first_or_create(password: 'password', password_confirmation: 'password')

  unless user.persisted?
    raise "Could not create user #{email}: #{user.errors.full_messages}"
  end
  user
  end

When /^I fill in the password field with "([^"]*)"$/ do |password|
  fill_in 'admin_user_password', with: password
end

Given /^an admin user "([^"]*)" exists$/ do |email|
  ensure_user_created(email)
end

When /^(?:I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, with: value)
end

When /^(?:I )press "([^"]*)"$/ do |button|
  click_link_or_button(button)
end

Then /^(?:I )should( not)? see( the element)? "([^"]*)"$/ do |negate, is_css, text|
  should = negate ? :not_to        : :to
  have   = is_css ? have_css(text) : have_content(text)
  expect(page).send should, have
end


Given(/^an admin exists with email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  @admin = FactoryGirl.create(:admin_user, email: email, password: password)
end

And(/^I'm loged in as admin user "([^"]*)"$/) do |email|
  login_as(@admin, scope: :admin_user)
end
