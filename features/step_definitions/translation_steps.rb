And(/^there are no custom translations$/) do
  Translation.destroy_all
  I18n.backend.reload!
end