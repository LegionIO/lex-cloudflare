# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/gateways'
require_relative 'runners/logs'
require_relative 'runners/datasets'
require_relative 'runners/evaluations'

module Legion
  module Extensions
    module Cloudflare
      module AiGateway
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Gateways
          include Runners::Logs
          include Runners::Datasets
          include Runners::Evaluations
        end
      end
    end
  end
end
