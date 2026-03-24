# frozen_string_literal: true

module Legion
  module Extensions
    module Cloudflare
      module Pages
        module Runners
          module Domains
            extend Legion::Extensions::Cloudflare::Helpers::Client

            def list_domains(account_id:, project_name:, **)
              response = client(**).get("/accounts/#{account_id}/pages/projects/#{project_name}/domains")
              { result: response.body, status: response.status }
            end

            def get_domain(account_id:, project_name:, domain_name:, **)
              response = client(**).get(
                "/accounts/#{account_id}/pages/projects/#{project_name}/domains/#{domain_name}"
              )
              { result: response.body, status: response.status }
            end

            def add_domain(account_id:, project_name:, name:, **)
              response = client(**).post(
                "/accounts/#{account_id}/pages/projects/#{project_name}/domains",
                { name: name }
              )
              { result: response.body, status: response.status }
            end

            def delete_domain(account_id:, project_name:, domain_name:, **)
              response = client(**).delete(
                "/accounts/#{account_id}/pages/projects/#{project_name}/domains/#{domain_name}"
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
