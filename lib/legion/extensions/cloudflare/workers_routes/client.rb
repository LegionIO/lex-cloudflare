# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/routes'

module Legion
  module Extensions
    module Cloudflare
      module WorkersRoutes
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Routes
        end
      end
    end
  end
end
