# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Dns
        module Runners
          module Dnssec
            extend Legion::Extensions::Cloudflare::Dns::Helpers::Client

            def get_dnssec(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}/dnssec")
              { result: response.body, status: response.status }
            end

            def edit_dnssec(zone_id:, body:, **)
              response = client(**).patch("/zones/#{zone_id}/dnssec", body)
              { result: response.body, status: response.status }
            end

            def delete_dnssec(zone_id:, **)
              response = client(**).delete("/zones/#{zone_id}/dnssec")
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
