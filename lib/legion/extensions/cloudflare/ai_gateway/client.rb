# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/gateways'
require_relative 'runners/logs'
require_relative 'runners/datasets'
require_relative 'runners/evaluations'

module Legion
  module Extensions
    module Cloudflare
      module AiGateway
        class Client
          include Helpers::Client
          include Runners::Gateways
          include Runners::Logs
          include Runners::Datasets
          include Runners::Evaluations

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
