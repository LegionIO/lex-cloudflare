# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module AiGateway
        module Runners
          module Datasets
            extend Legion::Extensions::Cloudflare::AiGateway::Helpers::Client

            def list_datasets(account_id:, gateway_id:, page: nil, per_page: nil, search: nil, **)
              params = { page: page, per_page: per_page, search: search }.compact
              response = client(**).get("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/datasets", params)
              { result: response.body, status: response.status }
            end

            def get_dataset(account_id:, gateway_id:, id:, **)
              response = client(**).get("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/datasets/#{id}")
              { result: response.body, status: response.status }
            end

            def create_dataset(account_id:, gateway_id:, body:, **)
              response = client(**).post("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/datasets", body)
              { result: response.body, status: response.status }
            end

            def update_dataset(account_id:, gateway_id:, id:, body:, **)
              response = client(**).put("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/datasets/#{id}", body)
              { result: response.body, status: response.status }
            end

            def delete_dataset(account_id:, gateway_id:, id:, **)
              response = client(**).delete("/accounts/#{account_id}/ai-gateway/gateways/#{gateway_id}/datasets/#{id}")
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
