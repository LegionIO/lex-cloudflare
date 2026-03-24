# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/certificate_packs'
require_relative 'runners/universal'

module Legion
  module Extensions
    module Cloudflare
      module Ssl
        class Client
          include Helpers::Client
          include Runners::CertificatePacks
          include Runners::Universal

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
