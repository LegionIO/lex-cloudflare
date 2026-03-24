# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Zones
        module Runners
          module Settings
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_settings(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}/settings")
              { result: response.body, status: response.status }
            end

            def get_setting(zone_id:, setting_id:, **)
              response = client(**).get("/zones/#{zone_id}/settings/#{setting_id}")
              { result: response.body, status: response.status }
            end

            include Legion::Extensions::Helpers::Lex if Legion::Extensions.const_defined?(:Helpers) &&
                                                        Legion::Extensions::Helpers.const_defined?(:Lex)
          end
        end
      end
    end
  end
end
