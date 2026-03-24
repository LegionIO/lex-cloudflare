# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Pages::Runners::Projects do
  let(:client)        { Legion::Extensions::Cloudflare::Pages::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_projects' do
    it 'GETs all Pages projects' do
      allow(connection).to receive(:get).with('/accounts/a1/pages/projects').and_return(list_response)
      result = client.list_projects(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_project' do
    it 'GETs a single project' do
      allow(connection).to receive(:get).with('/accounts/a1/pages/projects/my-site').and_return(ok_response)
      result = client.get_project(account_id: 'a1', project_name: 'my-site')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#create_project' do
    it 'POSTs a new project with production branch' do
      allow(connection).to receive(:post)
        .with('/accounts/a1/pages/projects', { name: 'my-site', production_branch: 'main' })
        .and_return(ok_response)
      result = client.create_project(account_id: 'a1', name: 'my-site', production_branch: 'main')
      expect(result[:status]).to eq(200)
    end

    it 'POSTs a new project without production branch' do
      allow(connection).to receive(:post)
        .with('/accounts/a1/pages/projects', { name: 'my-site' })
        .and_return(ok_response)
      result = client.create_project(account_id: 'a1', name: 'my-site')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_project' do
    it 'DELETEs a project' do
      allow(connection).to receive(:delete).with('/accounts/a1/pages/projects/my-site').and_return(ok_response)
      result = client.delete_project(account_id: 'a1', project_name: 'my-site')
      expect(result[:status]).to eq(200)
    end
  end
end
