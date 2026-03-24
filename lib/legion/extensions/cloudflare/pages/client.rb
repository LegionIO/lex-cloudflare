# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/projects'
require_relative 'runners/deployments'
require_relative 'runners/domains'

module Legion
  module Extensions
    module Cloudflare
      module Pages
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Projects
          include Runners::Deployments
          include Runners::Domains
        end
      end
    end
  end
end
