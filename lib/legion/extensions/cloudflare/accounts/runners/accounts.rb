# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Accounts
        module Runners
          module Accounts
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list(page: nil, per_page: nil, name: nil, **)
              params = { page: page, per_page: per_page, name: name }.compact
              response = client(**).get('/accounts', params)
              { result: response.body, status: response.status }
            end

            def get(account_id:, **)
              response = client(**).get("/accounts/#{account_id}")
              { result: response.body, status: response.status }
            end

            def create(name:, type: nil, **)
              body = { name: name, type: type }.compact
              response = client(**).post('/accounts', body)
              { result: response.body, status: response.status }
            end

            def update(account_id:, body:, **)
              response = client(**).put("/accounts/#{account_id}", body)
              { result: response.body, status: response.status }
            end

            def delete(account_id:, **)
              response = client(**).delete("/accounts/#{account_id}")
              { result: response.body, status: response.status }
            end

            def get_profile(account_id:, **)
              response = client(**).get("/accounts/#{account_id}/profile")
              { result: response.body, status: response.status }
            end

            def update_profile(account_id:, body:, **)
              response = client(**).put("/accounts/#{account_id}/profile", body)
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
