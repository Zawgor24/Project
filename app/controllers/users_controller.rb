# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
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

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name,
      :birthday, :info, :address, :sex, :avatar)
  end
end
