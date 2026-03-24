# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Accounts
        module Runners
          module Roles
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_roles(account_id:, page: nil, per_page: nil, **)
              params = { page: page, per_page: per_page }.compact
              response = client(**).get("/accounts/#{account_id}/roles", params)
              { result: response.body, status: response.status }
            end

            def get_role(account_id:, role_id:, **)
              response = client(**).get("/accounts/#{account_id}/roles/#{role_id}")
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
