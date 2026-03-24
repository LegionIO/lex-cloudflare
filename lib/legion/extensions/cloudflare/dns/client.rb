# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/records'
require_relative 'runners/dnssec'

module Legion
  module Extensions
    module Cloudflare
      module Dns
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Records
          include Runners::Dnssec
        end
      end
    end
  end
end
