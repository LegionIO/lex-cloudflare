# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/indexes'
require_relative 'runners/vectors'

module Legion
  module Extensions
    module Cloudflare
      module Vectorize
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Indexes
          include Runners::Vectors
        end
      end
    end
  end
end
