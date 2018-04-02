# frozen_string_literal: true

class PhoneVerificationsController < ApplicationController
  before_action :authorize_verification, only: :create

  def create
    UsersPhoneService.save(
      current_user,
      params[:phone_number],
      params[:country_code]
    )

    @response = AuthyService.start(current_user, params[:method])

    if @response.ok?
      redirect_to challenge_phone_verifications_path
    else
      render :new
    end
  end

  def verify
    @response = AuthyService.check(current_user, params[:code])

    if @response.ok?
      redirect_to success_phone_verifications_path
    else
      render :challenge, warning: t('notices.error')
    end
  end

  private

  def authorize_verification
    authorize self
  end
end
