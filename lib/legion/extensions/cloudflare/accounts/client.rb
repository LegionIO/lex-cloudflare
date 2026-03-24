# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/accounts'
require_relative 'runners/members'
require_relative 'runners/roles'
require_relative 'runners/tokens'

module Legion
  module Extensions
    module Cloudflare
      module Accounts
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Accounts
          include Runners::Members
          include Runners::Roles
          include Runners::Tokens
        end
      end
    end
  end
end
