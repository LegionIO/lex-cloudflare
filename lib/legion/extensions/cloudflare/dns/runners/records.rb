# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Dns
        module Runners
          module Records
            extend Legion::Extensions::Cloudflare::Dns::Helpers::Client

            def list(zone_id:, type: nil, name: nil, page: nil, per_page: nil, **)
              params = { type: type, name: name, page: page, per_page: per_page }.compact
              response = client(**).get("/zones/#{zone_id}/dns_records", params)
              { result: response.body, status: response.status }
            end

            def get(zone_id:, dns_record_id:, **)
              response = client(**).get("/zones/#{zone_id}/dns_records/#{dns_record_id}")
              { result: response.body, status: response.status }
            end

            def create(zone_id:, body:, **)
              response = client(**).post("/zones/#{zone_id}/dns_records", body)
              { result: response.body, status: response.status }
            end

            def update(zone_id:, dns_record_id:, body:, **)
              response = client(**).patch("/zones/#{zone_id}/dns_records/#{dns_record_id}", body)
              { result: response.body, status: response.status }
            end

            def delete(zone_id:, dns_record_id:, **)
              response = client(**).delete("/zones/#{zone_id}/dns_records/#{dns_record_id}")
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
