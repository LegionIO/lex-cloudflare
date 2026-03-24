# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/models'
require_relative 'runners/finetunes'

module Legion
  module Extensions
    module Cloudflare
      module Ai
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Models
          include Runners::Finetunes
        end
      end
    end
  end
end
