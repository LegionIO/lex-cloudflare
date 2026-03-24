# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Pages::Runners::Deployments do
  let(:client)        { Legion::Extensions::Cloudflare::Pages::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_deployments' do
    it 'GETs all deployments for a project' do
      allow(connection).to receive(:get)
        .with('/accounts/a1/pages/projects/my-site/deployments')
        .and_return(list_response)
      result = client.list_deployments(account_id: 'a1', project_name: 'my-site')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_deployment' do
    it 'GETs a single deployment' do
      allow(connection).to receive(:get)
        .with('/accounts/a1/pages/projects/my-site/deployments/d1')
        .and_return(ok_response)
      result = client.get_deployment(account_id: 'a1', project_name: 'my-site', deployment_id: 'd1')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#delete_deployment' do
    it 'DELETEs a deployment' do
      allow(connection).to receive(:delete)
        .with('/accounts/a1/pages/projects/my-site/deployments/d1')
        .and_return(ok_response)
      result = client.delete_deployment(account_id: 'a1', project_name: 'my-site', deployment_id: 'd1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#retry_deployment' do
    it 'POSTs to retry a deployment' do
      allow(connection).to receive(:post)
        .with('/accounts/a1/pages/projects/my-site/deployments/d1/retry')
        .and_return(ok_response)
      result = client.retry_deployment(account_id: 'a1', project_name: 'my-site', deployment_id: 'd1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#rollback_deployment' do
    it 'POSTs to rollback to a deployment' do
      allow(connection).to receive(:post)
        .with('/accounts/a1/pages/projects/my-site/deployments/d1/rollback')
        .and_return(ok_response)
      result = client.rollback_deployment(account_id: 'a1', project_name: 'my-site', deployment_id: 'd1')
      expect(result[:status]).to eq(200)
    end
  end
end
