# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :name, :parent_id

  form do |f|
    f.inputs t('admin.required_info') do
      f.input :name
      f.input :parent_id, label: t('admin.member'), as: :select,
                          collection: Category.all.map { |u| [u.name, u.id] }
    end
    f.actions
  end
end
