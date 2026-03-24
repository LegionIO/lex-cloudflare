# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Pages::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'sets the Authorization header' do
    expect(client.client.headers['Authorization']).to eq('Bearer test-token')
  end

  it 'includes Projects runner' do
    expect(client).to respond_to(:list_projects)
    expect(client).to respond_to(:get_project)
    expect(client).to respond_to(:create_project)
    expect(client).to respond_to(:delete_project)
  end

  it 'includes Deployments runner' do
    expect(client).to respond_to(:list_deployments)
    expect(client).to respond_to(:get_deployment)
    expect(client).to respond_to(:retry_deployment)
    expect(client).to respond_to(:rollback_deployment)
    expect(client).to respond_to(:delete_deployment)
  end

  it 'includes Domains runner' do
    expect(client).to respond_to(:list_domains)
    expect(client).to respond_to(:get_domain)
    expect(client).to respond_to(:add_domain)
    expect(client).to respond_to(:delete_domain)
  end
end
