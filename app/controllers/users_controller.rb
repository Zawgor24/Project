# frozen_string_literal: true

class UsersController < ApplicationController
  expose :user, decorate: ->(user) { UserDecorator.new(user) }

  before_action :authorize_user, only: %i[edit update destroy]

  def edit; end

  def update
    if user.update(user_params)
      redirect_to user
    else
      render :edit, danger: t('notices.error')
    end
  end

  def destroy
    user.destroy

    redirect_to root_path
  end

  private

  def authorize_user
    authorize user
  end

  def user_params
    params.require(:user).permit(:address, :avatar, :birthday, :email,
      :first_name, :info, :last_name, :password, :sex)
  end
end
