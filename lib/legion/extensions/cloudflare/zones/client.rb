# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/zones'
require_relative 'runners/settings'

module Legion
  module Extensions
    module Cloudflare
      module Zones
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Zones
          include Runners::Settings
        end
      end
    end
  end
end
