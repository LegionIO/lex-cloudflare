# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Pages
        module Runners
          module Deployments
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_deployments(account_id:, project_name:, **)
              response = client(**).get("/accounts/#{account_id}/pages/projects/#{project_name}/deployments")
              { result: response.body, status: response.status }
            end

            def get_deployment(account_id:, project_name:, deployment_id:, **)
              response = client(**).get(
                "/accounts/#{account_id}/pages/projects/#{project_name}/deployments/#{deployment_id}"
              )
              { result: response.body, status: response.status }
            end

            def delete_deployment(account_id:, project_name:, deployment_id:, **)
              response = client(**).delete(
                "/accounts/#{account_id}/pages/projects/#{project_name}/deployments/#{deployment_id}"
              )
              { result: response.body, status: response.status }
            end

            def retry_deployment(account_id:, project_name:, deployment_id:, **)
              response = client(**).post(
                "/accounts/#{account_id}/pages/projects/#{project_name}/deployments/#{deployment_id}/retry"
              )
              { result: response.body, status: response.status }
            end

            def rollback_deployment(account_id:, project_name:, deployment_id:, **)
              response = client(**).post(
                "/accounts/#{account_id}/pages/projects/#{project_name}/deployments/#{deployment_id}/rollback"
              )
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
