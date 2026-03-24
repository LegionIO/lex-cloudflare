# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module ZeroTrust
        module Runners
          module IpProfiles
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_ip_profiles(account_id:, per_page: nil, **)
              params = { per_page: per_page }.compact
              response = client(**).get("/accounts/#{account_id}/devices/ip-profiles", params)
              { result: response.body, status: response.status }
            end

            def get_ip_profile(account_id:, profile_id:, **)
              response = client(**).get("/accounts/#{account_id}/devices/ip-profiles/#{profile_id}")
              { result: response.body, status: response.status }
            end

            def create_ip_profile(account_id:, body:, **)
              response = client(**).post("/accounts/#{account_id}/devices/ip-profiles", body)
              { result: response.body, status: response.status }
            end

            def update_ip_profile(account_id:, profile_id:, body:, **)
              response = client(**).patch("/accounts/#{account_id}/devices/ip-profiles/#{profile_id}", body)
              { result: response.body, status: response.status }
            end

            def delete_ip_profile(account_id:, profile_id:, **)
              response = client(**).delete("/accounts/#{account_id}/devices/ip-profiles/#{profile_id}")
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
