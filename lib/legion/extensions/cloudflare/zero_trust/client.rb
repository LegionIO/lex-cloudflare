# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/devices'
require_relative 'runners/registrations'
require_relative 'runners/dex_tests'
require_relative 'runners/ip_profiles'

module Legion
  module Extensions
    module Cloudflare
      module ZeroTrust
        class Client
          include Helpers::Client
          include Runners::Devices
          include Runners::Registrations
          include Runners::DexTests
          include Runners::IpProfiles

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
