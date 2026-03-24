# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Zones
        module Runners
          module Zones
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list(page: nil, per_page: nil, name: nil, status: nil, **)
              params = { page: page, per_page: per_page, name: name, status: status }.compact
              response = client(**).get('/zones', params)
              { result: response.body, status: response.status }
            end

            def get(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}")
              { result: response.body, status: response.status }
            end

            def create(name:, account_id: nil, type: nil, **)
              body = { name: name }
              body[:account] = { id: account_id } if account_id
              body[:type] = type if type
              response = client(**).post('/zones', body)
              { result: response.body, status: response.status }
            end

            def update(zone_id:, body:, **)
              response = client(**).patch("/zones/#{zone_id}", body)
              { result: response.body, status: response.status }
            end

            def delete(zone_id:, **)
              response = client(**).delete("/zones/#{zone_id}")
              { result: response.body, status: response.status }
            end

            def activation_check(zone_id:, **)
              response = client(**).put("/zones/#{zone_id}/activation_check")
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
