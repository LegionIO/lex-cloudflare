# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      class BaseClient
        include Helpers::Client

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
