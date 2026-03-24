# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module DnsFirewall
        module Runners
          module Clusters
            extend Legion::Extensions::Cloudflare::DnsFirewall::Helpers::Client

            def list(account_id:, page: nil, per_page: nil, **)
              params = { page: page, per_page: per_page }.compact
              response = client(**).get("/accounts/#{account_id}/dns_firewall", params)
              { result: response.body, status: response.status }
            end

            def get(account_id:, dns_firewall_id:, **)
              response = client(**).get("/accounts/#{account_id}/dns_firewall/#{dns_firewall_id}")
              { result: response.body, status: response.status }
            end

            def create(account_id:, name:, upstream_ips:, **extra)
              body = { name: name, upstream_ips: upstream_ips, **extra }.compact
              response = client(**extra).post("/accounts/#{account_id}/dns_firewall", body)
              { result: response.body, status: response.status }
            end

            def update(account_id:, dns_firewall_id:, body:, **)
              response = client(**).patch("/accounts/#{account_id}/dns_firewall/#{dns_firewall_id}", body)
              { result: response.body, status: response.status }
            end

            def delete(account_id:, dns_firewall_id:, **)
              response = client(**).delete("/accounts/#{account_id}/dns_firewall/#{dns_firewall_id}")
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
