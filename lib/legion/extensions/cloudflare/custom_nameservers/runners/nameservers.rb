# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module CustomNameservers
        module Runners
          module Nameservers
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list(account_id:, **)
              response = client(**).get("/accounts/#{account_id}/custom_ns")
              { result: response.body, status: response.status }
            end

            def add(account_id:, ns_name:, ns_set: nil, **)
              body = { ns_name: ns_name, ns_set: ns_set }.compact
              response = client(**).post("/accounts/#{account_id}/custom_ns", body)
              { result: response.body, status: response.status }
            end

            def delete(account_id:, custom_ns_id:, **)
              response = client(**).delete("/accounts/#{account_id}/custom_ns/#{custom_ns_id}")
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
