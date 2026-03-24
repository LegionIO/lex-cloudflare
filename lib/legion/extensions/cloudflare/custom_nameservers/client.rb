# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/nameservers'

module Legion
  module Extensions
    module Cloudflare
      module CustomNameservers
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::Nameservers
        end
      end
    end
  end
end
