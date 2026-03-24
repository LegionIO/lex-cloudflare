# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module WorkersRoutes
        module Runners
          module Routes
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_routes(zone_id:, **)
              response = client(**).get("/zones/#{zone_id}/workers/routes")
              { result: response.body, status: response.status }
            end

            def get_route(zone_id:, route_id:, **)
              response = client(**).get("/zones/#{zone_id}/workers/routes/#{route_id}")
              { result: response.body, status: response.status }
            end

            def create_route(zone_id:, pattern:, script: nil, **)
              body = { pattern: pattern }
              body[:script] = script if script
              response = client(**).post("/zones/#{zone_id}/workers/routes", body)
              { result: response.body, status: response.status }
            end

            def update_route(zone_id:, route_id:, pattern:, script: nil, **)
              body = { pattern: pattern }
              body[:script] = script if script
              response = client(**).put("/zones/#{zone_id}/workers/routes/#{route_id}", body)
              { result: response.body, status: response.status }
            end

            def delete_route(zone_id:, route_id:, **)
              response = client(**).delete("/zones/#{zone_id}/workers/routes/#{route_id}")
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
