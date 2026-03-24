# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Accounts
        module Runners
          module Tokens
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_tokens(account_id:, page: nil, per_page: nil, **)
              params = { page: page, per_page: per_page }.compact
              response = client(**).get("/accounts/#{account_id}/tokens", params)
              { result: response.body, status: response.status }
            end

            def get_token(account_id:, token_id:, **)
              response = client(**).get("/accounts/#{account_id}/tokens/#{token_id}")
              { result: response.body, status: response.status }
            end

            def create_token(account_id:, name:, policies:, expires_on: nil, not_before: nil, condition: nil, **)
              body = { name: name, policies: policies, expires_on: expires_on,
                       not_before: not_before, condition: condition }.compact
              response = client(**).post("/accounts/#{account_id}/tokens", body)
              { result: response.body, status: response.status }
            end

            def update_token(account_id:, token_id:, body:, **)
              response = client(**).put("/accounts/#{account_id}/tokens/#{token_id}", body)
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
