# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Ai
        module Runners
          module Models
            extend Legion::Extensions::Cloudflare::Ai::Helpers::Client

            def run(account_id:, model_name:, body:, **)
              response = client(**).post("/accounts/#{account_id}/ai/run/#{model_name}", body)
              { result: response.body, status: response.status }
            end

            def search_models(account_id:, search: nil, author: nil, task: nil, page: nil, per_page: nil, **)
              params = { search: search, author: author, task: task, page: page, per_page: per_page }.compact
              response = client(**).get("/accounts/#{account_id}/ai/models/search", params)
              { result: response.body, status: response.status }
            end

            def model_schema(account_id:, model:, **)
              response = client(**).get("/accounts/#{account_id}/ai/models/schema", { model: model })
              { result: response.body, status: response.status }
            end

            def to_markdown(account_id:, body:, **)
              response = client(**).post("/accounts/#{account_id}/ai/tomarkdown", body)
              { result: response.body, status: response.status }
            end

            def supported_markdown_formats(account_id:, **)
              response = client(**).get("/accounts/#{account_id}/ai/tomarkdown/supported")
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
