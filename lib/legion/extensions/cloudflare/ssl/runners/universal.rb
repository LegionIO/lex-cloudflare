# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Ssl
        module Runners
          module Universal
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def get_universal_settings(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}/ssl/universal/settings")
              { result: response.body, status: response.status }
            end

            def update_universal_settings(zone_id:, enabled:, **)
              response = client(**).patch("/zones/#{zone_id}/ssl/universal/settings", { enabled: enabled })
              { result: response.body, status: response.status }
            end

            def get_recommendation(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}/ssl/recommendation")
              { result: response.body, status: response.status }
            end

            def list_verification(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}/ssl/verification")
              { result: response.body, status: response.status }
            end

            def update_verification(zone_id:, certificate_pack_id:, validation_method:, **)
              body = { validation_method: validation_method }
              response = client(**).patch("/zones/#{zone_id}/ssl/verification/#{certificate_pack_id}", body)
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
