# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Ssl
        module Runners
          module CertificatePacks
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_packs(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}/ssl/certificate_packs")
              { result: response.body, status: response.status }
            end

            def get_pack(zone_id:, certificate_pack_id:, **)
              response = client(**).get("/zones/#{zone_id}/ssl/certificate_packs/#{certificate_pack_id}")
              { result: response.body, status: response.status }
            end

            def order_pack(zone_id:, body:, **)
              response = client(**).post("/zones/#{zone_id}/ssl/certificate_packs/order", body)
              { result: response.body, status: response.status }
            end

            def update_pack(zone_id:, certificate_pack_id:, body: {}, **)
              response = client(**).patch("/zones/#{zone_id}/ssl/certificate_packs/#{certificate_pack_id}", body)
              { result: response.body, status: response.status }
            end

            def delete_pack(zone_id:, certificate_pack_id:, **)
              response = client(**).delete("/zones/#{zone_id}/ssl/certificate_packs/#{certificate_pack_id}")
              { result: response.body, status: response.status }
            end

            def quota(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}/ssl/certificate_packs/quota")
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
