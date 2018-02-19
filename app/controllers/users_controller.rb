# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, danger: t('notices.error')
    end
  end

  def destroy
    @user.destroy

    redirect_to root_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize @user
  end

  def user_params
    params.require(:user).permit(:address, :avatar, :birthday, :email,
      :first_name, :info, :last_name, :password, :sex)
  end
end
