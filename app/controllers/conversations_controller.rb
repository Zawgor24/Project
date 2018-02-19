# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :find_conversation, only: %i[show destroy]
  before_action :find_receipts, only: :show

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show; end

  def create
    recipient = User.find(params[:user_id])

    receipt = current_user.send_message(recipient,
      t('messages.greeting', name: current_user.first_name), recipient.email)

    redirect_to conversation_path(receipt.conversation)
  end

  def destroy
    @conversation.destroy

    redirect_to user_conversations_path(current_user)
  end

  private

  def find_receipts
    @receipts = @conversation.receipts_for(current_user).order(:created_at)
  end

  def find_conversation
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end
end
