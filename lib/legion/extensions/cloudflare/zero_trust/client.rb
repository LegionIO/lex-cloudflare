# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/devices'
require_relative 'runners/registrations'
require_relative 'runners/dex_tests'
require_relative 'runners/ip_profiles'

module Legion
  module Extensions
    module Cloudflare
      module ZeroTrust
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Devices
          include Runners::Registrations
          include Runners::DexTests
          include Runners::IpProfiles
        end
      end
    end
  end
end
