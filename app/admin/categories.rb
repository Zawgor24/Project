# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :name

  form do |f|
    f.inputs t(:required_info) do
      f.input :name
    end
    f.actions
  end
end
