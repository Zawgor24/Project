# frozen_string_literal: true

Mailboxer.setup do |config|
  config.uses_emails = false
  config.default_from = 'no-reply@mailboxer.com'
  config.email_method = :mailboxer_email
  config.name_method = :name
  config.notify_method = :notify
  config.search_enabled = false
  config.search_engine = :solr
  config.subject_max_length = 255
  config.body_max_length = 32_000
  config.email_method = :mailboxer_email
  config.name_method = :mailboxer_name
end
