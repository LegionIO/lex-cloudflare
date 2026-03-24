# frozen_string_literal: true

require_relative 'cloudflare/version'
require_relative 'cloudflare/helpers/client'
require_relative 'cloudflare/base_client'
require_relative 'cloudflare/dns'
require_relative 'cloudflare/dns_firewall'
require_relative 'cloudflare/custom_nameservers'
require_relative 'cloudflare/zero_trust'
require_relative 'cloudflare/ssl'
require_relative 'cloudflare/vectorize'
require_relative 'cloudflare/ai_gateway'
require_relative 'cloudflare/ai'
require_relative 'cloudflare/zones'
require_relative 'cloudflare/accounts'

module Legion
  module Extensions
    module Cloudflare
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
