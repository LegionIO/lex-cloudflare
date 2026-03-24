# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Accounts
        module Runners
          module Members
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_members(account_id:, page: nil, per_page: nil, status: nil, **)
              params = { page: page, per_page: per_page, status: status }.compact
              response = client(**).get("/accounts/#{account_id}/members", params)
              { result: response.body, status: response.status }
            end

            def get_member(account_id:, member_id:, **)
              response = client(**).get("/accounts/#{account_id}/members/#{member_id}")
              { result: response.body, status: response.status }
            end

            def add_member(account_id:, email:, roles:, **)
              body = { email: email, roles: roles }
              response = client(**).post("/accounts/#{account_id}/members", body)
              { result: response.body, status: response.status }
            end

            def update_member(account_id:, member_id:, body:, **)
              response = client(**).put("/accounts/#{account_id}/members/#{member_id}", body)
              { result: response.body, status: response.status }
            end

            def remove_member(account_id:, member_id:, **)
              response = client(**).delete("/accounts/#{account_id}/members/#{member_id}")
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
