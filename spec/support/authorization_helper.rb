# frozen_string_literal: true

module AuthorizationHelper
  def sign_in(user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Submit'
  end

  def sign_up(user)
    visit new_user_registration_path

    fill_in 'user[first_name]', with: user.first_name
    fill_in 'user[last_name]', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Submit'
  end
end
