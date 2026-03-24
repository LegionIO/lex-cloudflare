# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/clusters'
require_relative 'runners/analytics'

module Legion
  module Extensions
    module Cloudflare
      module DnsFirewall
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Clusters
          include Runners::Analytics
        end
      end
    end
  end
end
