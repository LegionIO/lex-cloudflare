# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/indexes'
require_relative 'runners/vectors'

module Legion
  module Extensions
    module Cloudflare
      module Vectorize
        class Client
          include Helpers::Client
          include Runners::Indexes
          include Runners::Vectors

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
