# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module AiGateway
        module Runners
          module Evaluations
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_evaluations(account_id:, gateway_id:, page: nil, per_page: nil, **)
              params = { page: page, per_page: per_page }.compact
              response = client(**).get("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/evaluations", params)
              { result: response.body, status: response.status }
            end

            def get_evaluation(account_id:, gateway_id:, id:, **)
              response = client(**).get("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/evaluations/#{id}")
              { result: response.body, status: response.status }
            end

            def create_evaluation(account_id:, gateway_id:, body:, **)
              response = client(**).post("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/evaluations", body)
              { result: response.body, status: response.status }
            end

            def delete_evaluation(account_id:, gateway_id:, id:, **)
              response = client(**).delete("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/evaluations/#{id}")
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
