# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module AiGateway
        module Runners
          module Logs
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_logs(account_id:, gateway_id:, page: nil, per_page: nil, **)
              params = { page: page, per_page: per_page }.compact
              response = client(**).get("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/logs", params)
              { result: response.body, status: response.status }
            end

            def get_log(account_id:, gateway_id:, id:, **)
              response = client(**).get("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/logs/#{id}")
              { result: response.body, status: response.status }
            end

            def patch_log(account_id:, gateway_id:, id:, body:, **)
              response = client(**).patch("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/logs/#{id}", body)
              { result: response.body, status: response.status }
            end

            def delete_logs(account_id:, gateway_id:, **)
              response = client(**).delete("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/logs")
              { result: response.body, status: response.status }
            end

            def get_log_request(account_id:, gateway_id:, id:, **)
              response = client(**).get("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/logs/#{id}/request")
              { result: response.body, status: response.status }
            end

            def get_log_response(account_id:, gateway_id:, id:, **)
              response = client(**).get("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/logs/#{id}/response")
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
