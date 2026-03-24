# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Pages::Runners::Domains do
  let(:client)        { Legion::Extensions::Cloudflare::Pages::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_domains' do
    it 'GETs all custom domains for a project' do
      allow(connection).to receive(:get)
        .with('/accounts/a1/pages/projects/my-site/domains')
        .and_return(list_response)
      result = client.list_domains(account_id: 'a1', project_name: 'my-site')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_domain' do
    it 'GETs a single custom domain' do
      allow(connection).to receive(:get)
        .with('/accounts/a1/pages/projects/my-site/domains/example.com')
        .and_return(ok_response)
      result = client.get_domain(account_id: 'a1', project_name: 'my-site', domain_name: 'example.com')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#add_domain' do
    it 'POSTs a new custom domain' do
      allow(connection).to receive(:post)
        .with('/accounts/a1/pages/projects/my-site/domains', { name: 'example.com' })
        .and_return(ok_response)
      result = client.add_domain(account_id: 'a1', project_name: 'my-site', name: 'example.com')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_domain' do
    it 'DELETEs a custom domain' do
      allow(connection).to receive(:delete)
        .with('/accounts/a1/pages/projects/my-site/domains/example.com')
        .and_return(ok_response)
      result = client.delete_domain(account_id: 'a1', project_name: 'my-site', domain_name: 'example.com')
      expect(result[:status]).to eq(200)
    end
  end
end
