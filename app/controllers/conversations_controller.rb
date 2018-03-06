# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :find_conversation, only: %i[show destroy]
  before_action :find_receipts, only: :show
  before_action :find_trash_conversation, only: :untrash

  def index
    @conversations = mailbox.sentbox
  end

  def show
    @conversation.mark_as_read(current_user)
  end

  def create
    receipt = current_user.send_message(recipient, body, recipient.email)

    redirect_to conversation_path(receipt.conversation)
  end

  def destroy
    @conversation.move_to_trash(current_user)

    redirect_to user_conversations_path(current_user)
  end

  def untrash
    @conversation.untrash(current_user)

    redirect_to user_conversations_path(current_user)
  end

  private

  def body
    t('messages.greeting', name: current_user.first_name)
  end

  def companion(conversation)
    conversation.recipients.reject { |recip| recip.eql?(current_user) }.first
  end

  def find_conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def find_receipts
    @receipts = @conversation.receipts_for(current_user)
      .order(:created_at).includes(:message)
  end

  def find_trash_conversation
    @conversation ||= mailbox.conversations.find(
      params[:conversation_id]
    )
  end

  def recipient
    User.find_by(id: params[:user_id])
  end
end
