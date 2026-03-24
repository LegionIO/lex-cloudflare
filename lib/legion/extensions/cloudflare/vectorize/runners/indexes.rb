# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Vectorize
        module Runners
          module Indexes
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_indexes(account_id:, **)
              response = client(**).get("/accounts/#{account_id}/vectorize/v2/indexes")
              { result: response.body, status: response.status }
            end

            def get_index(account_id:, index_name:, **)
              response = client(**).get("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}")
              { result: response.body, status: response.status }
            end

            def create_index(account_id:, name:, config:, description: nil, **)
              body = { name: name, config: config, description: description }.compact
              response = client(**).post("/accounts/#{account_id}/vectorize/v2/indexes", body)
              { result: response.body, status: response.status }
            end

            def delete_index(account_id:, index_name:, **)
              response = client(**).delete("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}")
              { result: response.body, status: response.status }
            end

            def index_info(account_id:, index_name:, **)
              response = client(**).get("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/info")
              { result: response.body, status: response.status }
            end

            def list_metadata_indexes(account_id:, index_name:, **)
              response = client(**).get("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/metadata_index/list")
              { result: response.body, status: response.status }
            end

            def create_metadata_index(account_id:, index_name:, property_name:, index_type:, **)
              body = { propertyName: property_name, indexType: index_type }
              response = client(**).post("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/metadata_index/create", body)
              { result: response.body, status: response.status }
            end

            def delete_metadata_index(account_id:, index_name:, property_name:, **)
              body = { propertyName: property_name }
              response = client(**).post("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/metadata_index/delete", body)
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
