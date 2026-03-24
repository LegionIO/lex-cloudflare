# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module DnsFirewall
        module Runners
          module Analytics
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def report(account_id:, dns_firewall_id:, **)
              response = client(**).get("/accounts/#{account_id}/dns_firewall/#{dns_firewall_id}/dns_analytics/report")
              { result: response.body, status: response.status }
            end

            def report_by_time(account_id:, dns_firewall_id:, time_delta: nil, **)
              params = { time_delta: time_delta }.compact
              response = client(**).get(
                "/accounts/#{account_id}/dns_firewall/#{dns_firewall_id}/dns_analytics/report/bytime",
                params
              )
              { result: response.body, status: response.status }
            end

            def get_reverse_dns(account_id:, dns_firewall_id:, **)
              response = client(**).get("/accounts/#{account_id}/dns_firewall/#{dns_firewall_id}/reverse_dns")
              { result: response.body, status: response.status }
            end

            def update_reverse_dns(account_id:, dns_firewall_id:, body:, **)
              response = client(**).patch("/accounts/#{account_id}/dns_firewall/#{dns_firewall_id}/reverse_dns", body)
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
