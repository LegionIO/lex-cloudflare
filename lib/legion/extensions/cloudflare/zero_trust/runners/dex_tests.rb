# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module ZeroTrust
        module Runners
          module DexTests
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_dex_tests(account_id:, page: nil, per_page: nil, **)
              params = { page: page, per_page: per_page }.compact
              response = client(**).get("/accounts/#{account_id}/dex/devices/dex_tests", params)
              { result: response.body, status: response.status }
            end

            def get_dex_test(account_id:, dex_test_id:, **)
              response = client(**).get("/accounts/#{account_id}/dex/devices/dex_tests/#{dex_test_id}")
              { result: response.body, status: response.status }
            end

            def create_dex_test(account_id:, body:, **)
              response = client(**).post("/accounts/#{account_id}/dex/devices/dex_tests", body)
              { result: response.body, status: response.status }
            end

            def update_dex_test(account_id:, dex_test_id:, body:, **)
              response = client(**).put("/accounts/#{account_id}/dex/devices/dex_tests/#{dex_test_id}", body)
              { result: response.body, status: response.status }
            end

            def delete_dex_test(account_id:, dex_test_id:, **)
              response = client(**).delete("/accounts/#{account_id}/dex/devices/dex_tests/#{dex_test_id}")
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
