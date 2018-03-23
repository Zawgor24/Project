# frozen_string_literal: true

class MailboxController < ApplicationController
  def inbox
    @inbox = decorate_mailboxer(mailbox.inbox)
  end

  def sentbox
    @sentbox = decorate_mailboxer(mailbox.sentbox)
  end

  def trash
    @trash = decorate_mailboxer(mailbox.trash)
  end
end
