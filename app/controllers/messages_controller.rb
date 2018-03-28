# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :find_conversation

  def create
    current_user.reply_to_conversation(@conversation, params[:body])

    redirect_to request.referer
  end

  private

  def find_conversation
    @conversation = current_user.mailbox.conversations
      .find(params[:conversation_id])
  end
end
