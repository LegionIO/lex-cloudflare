# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/clusters'
require_relative 'runners/analytics'

module Legion
  module Extensions
    module Cloudflare
      module DnsFirewall
        class Client
          include Helpers::Client
          include Runners::Clusters
          include Runners::Analytics

          attr_reader :opts

          def initialize(api_token:, **extra)
            @opts = { api_token: api_token, **extra }.compact
          end

          def client(**override)
            super(**@opts, **override)
          end
        end
      end
    end
  end
end
