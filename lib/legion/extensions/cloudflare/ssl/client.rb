# frozen_string_literal: true

require_relative '../helpers/client'
require_relative '../base_client'
require_relative 'runners/certificate_packs'
require_relative 'runners/universal'

module Legion
  module Extensions
    module Cloudflare
      module Ssl
        class Client < Legion::Extensions::Cloudflare::BaseClient
          include Runners::CertificatePacks
          include Runners::Universal
        end
      end
    end
  end
end
