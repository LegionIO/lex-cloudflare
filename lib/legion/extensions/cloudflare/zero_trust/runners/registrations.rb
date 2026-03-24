# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module ZeroTrust
        module Runners
          module Registrations
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_registrations(account_id:, per_page: nil, search: nil, **)
              params = { per_page: per_page, search: search }.compact
              response = client(**).get("/accounts/#{account_id}/devices/registrations", params)
              { result: response.body, status: response.status }
            end

            def get_registration(account_id:, registration_id:, **)
              response = client(**).get("/accounts/#{account_id}/devices/registrations/#{registration_id}")
              { result: response.body, status: response.status }
            end

            def delete_registration(account_id:, registration_id:, **)
              response = client(**).delete("/accounts/#{account_id}/devices/registrations/#{registration_id}")
              { result: response.body, status: response.status }
            end

            def revoke_registrations(account_id:, ids:, **)
              response = client(**).post("/accounts/#{account_id}/devices/registrations/revoke", nil, { id: ids })
              { result: response.body, status: response.status }
            end

            def unrevoke_registrations(account_id:, ids:, **)
              response = client(**).post("/accounts/#{account_id}/devices/registrations/unrevoke", nil, { id: ids })
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
