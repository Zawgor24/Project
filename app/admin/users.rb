# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :address, :avatar, :birthday, :email, :first_name, :info,
    :last_name, :manager, :password, :sex

  active_admin_paranoia

  form do |f|
    f.inputs t('admin.required_info') do
      f.input :email
      f.input :password
      f.input :first_name
      f.input :last_name
    end

    f.inputs t('admin.additional_info') do
      f.input :address
      f.input :avatar
      f.input :birthday
      f.input :info
      f.input :sex
      f.input :manager
    end

    f.actions
  end
end
