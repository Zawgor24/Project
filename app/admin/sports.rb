# frozen_string_literal: true

ActiveAdmin.register Sport do
  permit_params :avatar, :info, :name

  form do |f|
    f.inputs t('admin.required_info') do
      f.input :name
      f.input :info
    end

    f.inputs t('admin.additional_info') do
      f.input :avatar
    end

    f.actions
  end
end
