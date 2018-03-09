# frozen_string_literal: true

server ENV['IP_ADDRESS'], user: 'deploy', roles: %w[app db web]
