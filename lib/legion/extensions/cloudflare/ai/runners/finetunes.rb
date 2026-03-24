# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Ai
        module Runners
          module Finetunes
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_finetunes(account_id:, **)
              response = client(**).get("/accounts/#{account_id}/ai/finetunes")
              { result: response.body, status: response.status }
            end

            def create_finetune(account_id:, model:, name:, description: nil, public: nil, **)
              body = { model: model, name: name, description: description, public: public }.compact
              response = client(**).post("/accounts/#{account_id}/ai/finetunes", body)
              { result: response.body, status: response.status }
            end

            def upload_finetune_asset(account_id:, finetune_id:, body:, **)
              response = client(**).post("/accounts/#{account_id}/ai/finetunes/#{finetune_id}/finetune-assets", body)
              { result: response.body, status: response.status }
            end

            def list_public_finetunes(account_id:, limit: nil, offset: nil, **)
              params = { limit: limit, offset: offset }.compact
              response = client(**).get("/accounts/#{account_id}/ai/finetunes/public", params)
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
