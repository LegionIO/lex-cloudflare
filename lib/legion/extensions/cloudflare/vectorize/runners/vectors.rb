# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Vectorize
        module Runners
          module Vectors
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def insert(account_id:, index_name:, body:, **)
              response = client(**).post("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/insert", body)
              { result: response.body, status: response.status }
            end

            def upsert(account_id:, index_name:, body:, **)
              response = client(**).post("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/upsert", body)
              { result: response.body, status: response.status }
            end

            def query(account_id:, index_name:, vector:, top_k: nil, filter: nil, return_metadata: nil, return_values: nil, **)
              body = { vector: vector, topK: top_k, filter: filter, returnMetadata: return_metadata, returnValues: return_values }.compact
              response = client(**).post("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/query", body)
              { result: response.body, status: response.status }
            end

            def get_by_ids(account_id:, index_name:, ids:, **)
              response = client(**).post("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/get_by_ids", { ids: ids })
              { result: response.body, status: response.status }
            end

            def delete_by_ids(account_id:, index_name:, ids:, **)
              response = client(**).post("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/delete_by_ids", { ids: ids })
              { result: response.body, status: response.status }
            end

            def list_vectors(account_id:, index_name:, **)
              response = client(**).get("/accounts/#{account_id}/vectorize/v2/indexes/#{index_name}/list")
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
