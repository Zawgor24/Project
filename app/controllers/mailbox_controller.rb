# frozen_string_literal: true

class MailboxController < ApplicationController
  def inbox
    @inbox = mailbox.inbox
  end

  def sentbox
    @sentbox = mailbox.sentbox
  end

  def trash
    @trash = mailbox.trash
  end
end
