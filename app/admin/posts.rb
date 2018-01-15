# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :avatar, :body, :category_id, :title, :user_id

  form do |f|
    f.inputs t(:required_info) do
      f.input :avatar
      f.input :body
      f.input :category
      f.input :title
      f.input :user_id, label: t(:member), as: :select,
                        collection: User.all.map { |u| [u.email, u.id] }
    end
    f.actions
  end
end
