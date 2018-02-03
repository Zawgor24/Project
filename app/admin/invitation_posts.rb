# frozen_string_literal: true

ActiveAdmin.register InvitationPost do
  permit_params :date, :info, :name, :sport_id, :user_id

  form do |f|
    f.inputs t(:required_info) do
      f.input :name
      f.input :info
      f.input :sport
      f.input :date
      f.input :user_id, label: t(:member), as: :select,
                        collection: User.all.map { |u| [u.email, u.id] }
    end
    f.actions
  end
end
