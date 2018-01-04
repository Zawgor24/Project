# frozen_string_literal: true

ActiveAdmin.setup do |config|
  config.site_title = 'My Project'
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path
  config.batch_actions = true
  config.localize_format = :long
end