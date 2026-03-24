# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module ZeroTrust
        module Runners
          module Devices
            extend Legion::Extensions::Cloudflare::ZeroTrust::Helpers::Client

            def list_devices(account_id:, per_page: nil, search: nil, **)
              params = { per_page: per_page, search: search }.compact
              response = client(**).get("/accounts/#{account_id}/devices/physical-devices", params)
              { result: response.body, status: response.status }
            end

            def get_device(account_id:, device_id:, **)
              response = client(**).get("/accounts/#{account_id}/devices/physical-devices/#{device_id}")
              { result: response.body, status: response.status }
            end

            def delete_device(account_id:, device_id:, **)
              response = client(**).delete("/accounts/#{account_id}/devices/physical-devices/#{device_id}")
              { result: response.body, status: response.status }
            end

            def revoke_device(account_id:, device_id:, **)
              response = client(**).post("/accounts/#{account_id}/devices/physical-devices/#{device_id}/revoke")
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
