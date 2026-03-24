# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/nameservers'

module Legion
  module Extensions
    module Cloudflare
      module CustomNameservers
        class Client
          include Helpers::Client
          include Runners::Nameservers

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
