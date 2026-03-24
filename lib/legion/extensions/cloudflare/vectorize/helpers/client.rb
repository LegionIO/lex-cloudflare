# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Cloudflare
      module Vectorize
        module Helpers
          module Client
            def client(api_token:, **)
              Faraday.new(url: 'https://api.cloudflare.com/client/v4') do |conn|
                conn.request :json
                conn.response :json, content_type: /\bjson$/
                conn.headers['Content-Type'] = 'application/json'
                conn.headers['Authorization'] = "Bearer #{api_token}"
              end
            end
          end
        end
      end
    end
  end
end
