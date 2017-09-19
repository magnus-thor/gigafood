ActiveAdmin.setup do |config|
  #
  config.site_title = 'Gigafood'
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path
  config.batch_actions = false
  config.localize_format = :long
  config.footer = 'Build with a lot of LOVE by the Summer 2017 CraftAcademy cohort!'
  config.comments_menu = false
  config.comments = false
  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add label: 'Admin', priority: 0
    end
  end
end


#  DateTime Picker settings

# This if for front-end javascript side
ActiveAdminDatetimepicker::Base.default_datetime_picker_options = {
    defaultDate: proc { Time.current.strftime('%Y-%m-%d 00:00') }
}
# This if for backend(Ruby)
ActiveAdminDatetimepicker::Base.format = '%Y-%m-%d %H:%M:%S'
