# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Pages
        module Runners
          module Projects
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_projects(account_id:, **)
              response = client(**).get("/accounts/#{account_id}/pages/projects")
              { result: response.body, status: response.status }
            end

            def get_project(account_id:, project_name:, **)
              response = client(**).get("/accounts/#{account_id}/pages/projects/#{project_name}")
              { result: response.body, status: response.status }
            end

            def create_project(account_id:, name:, production_branch: nil, **)
              body = { name: name }
              body[:production_branch] = production_branch if production_branch
              response = client(**).post("/accounts/#{account_id}/pages/projects", body)
              { result: response.body, status: response.status }
            end

            def delete_project(account_id:, project_name:, **)
              response = client(**).delete("/accounts/#{account_id}/pages/projects/#{project_name}")
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
