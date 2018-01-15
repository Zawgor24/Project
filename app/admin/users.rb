# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :address, :avatar, :birthday, :email, :first_name, :info,
    :last_name, :password, :sex

  active_admin_paranoia

  form do |f|
    f.inputs t(:required_info) do
      f.input :email
      f.input :password
    end

    f.inputs t(:additional_info) do
      f.input :address
      f.input :avatar
      f.input :birthday
      f.input :first_name
      f.input :info
      f.input :last_name
      f.input :sex
    end

    f.actions
  end
end
